
#===========================java.util.Properties===============================#
#"The Properties class represents a persistent set of properties...Each key and
#its corresponding value in the property list is a string."
#https://docs.oracle.com/javase/7/docs/api/java/util/Properties.html
#
#WRAPPER
type Properties
    jproperties::JProperties
end

#CONSTRUCTORS
##key, value argument
function Properties(key::AbstractString, value::AbstractString)
    jproperties = JProperties(())
    jcall(jproperties, "setProperty", JObject, (JString, JString), key, value)
    return Properties(jproperties)
end

##Dictionary argument
function Properties(d::Dict{String, String})
    jproperties = JProperties(())
    for (k, v) in d
        jcall(jproperties, "setProperty", JObject, (JString, JString), k, v)
    end
    return Properties(jproperties)
end

##Value-only argument. Key defaults to "annotators"
function Properties(value::AbstractString)
    return Properties("annotators", value)
end

#CONVENIENCE METHODS
##Returns a string 'val' corresponding to property 'key'
function get_property(jprops::JProperties, key::AbstractString="annotators")
    return jcall(jprops, "getProperty", JString, (JString,), key)
end
#------------------------------------------------------------------------------#



#===============edu.stanford.nlp.pipeline.StanfordCoreNLP======================#
#"This is a pipeline that takes in a string and returns various analyzed linguistic
#forms. The String is tokenized via a tokenizer (using a TokenizerAnnotator),
#and then other sequence model style annotation can be used to add things like
#lemmas, POS tags, and named entities. These are returned as a list of CoreLabels.
#Other analysis components build and store parse trees, dependency graphs, etc."
#https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/pipeline/StanfordCoreNLP.html
#
#WRAPPER
##StanfordCoreNLP wrapper
type StanfordCoreNLP
    jstanfordcorenlp::JStanfordCoreNLP
end

#CONSTRUCTORS
##Usage:
##      StanfordCoreNLP(Dict("annotations" => "tokenize,ssplit,pos")
##
##Annotations must be to the right of their dependencies. See--
##https://stanfordnlp.github.io/CoreNLP/dependencies.html
function StanfordCoreNLP(dict::Dict{String, String})
    properties = Properties(dict)
    return StanfordCoreNLP(JStanfordCoreNLP((JProperties,), properties))
end

##Usage:
##      StanfordCoreNLP("pos", "parse")
##
##Annotation arguments may be unordered. Dependencies are added automatically.
function StanfordCoreNLP(annotators::String...)
    if check_annotators(annotators...)
        annList = order!(dependencies(annotators...))
        annCSVString = join(annList, ",")
        jprops = JProperties(())
        jcall(jprops, "setProperty", JObject, (JString, JString), "annotators", annCSVString)
        return StanfordCoreNLP(JStanfordCoreNLP((JProperties,), jprops))
    else
        println("Invalid annotator in `StanfordCoreNLP` call.")
        return 1
    end
end

#CONVENIENCE METHODS
##Returns true if all arguments are valid annotators, false otherwise.
function check_annotators(annotators...)
    valid = true
        for ann in annotators
            valid = valid && in(ann, keys(ANNOTATOR_DEPENDENCIES))
        end
    return valid
end

##Accepts an unordered list of annotators and adds all dependencies. For example,
##annotator_list("ssplit") returns ["ssplit", "tokenize"].
function dependencies(annotators...)
    list = String[]
    for a in annotators
        for b in ANNOTATOR_DEPENDENCIES[a]
            push!(list, b)
        end
        push!(list, a)
    end
    return unique(list)
end

##Accepts a list of annotators and orders it in place according to ANNOTATORS.
function order!(annotators::Array{String,1})
    list = String[]
    for ann in ORDERED_ANNOTATOR_LIST
        if in(ann, annotators)
            push!(list, ann)
        end
    end
    annotators = list
end

#Returns a JProperties of a StanfordCoreNLP pipeline corresponding to `key`.
#Defaults to key = "annotators".
function get_properties(pipeline::StanfordCoreNLP)
    return jcall(pipeline.jstanfordcorenlp, "getProperties", JProperties, ())
end

#Return a String that gives detailed human-readable information about how much
#time was spent by each annotator and by the entire annotation pipeline.
function timinginformation(pipeline::StanfordCoreNLP)
    return jcall(pipeline.jstanfordcorenlp, "timingInformation", JString, ())
end
#------------------------------------------------------------------------------#



#====================edu.stanford.nlp.pipeline.Annotation======================#
#"An annotation representing a span of text in a document."
#https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/pipeline/Annotation.html
#
#WRAPPER
type Annotation
    jannotation::JAnnotation
end

#CONSTRUCTORS
##function Annotation(text::AbstractString)
##    jannotation = JAnnotation((JString,), text)
##    return Annotation(jannotation)
##end
function Annotation(text::AbstractString)
    return Annotation(JAnnotation((JString,), text))
end

#CONVENIENCE METHODS
##Returns iterable list of sentences in an annotated text.
function sentences(doc::Annotation)
    return narrow(jcall(doc.jannotation, "get", JObject, (JClass,), JSentencesAnnotationClass))
end

##Returns a CorefChainAnnotation HashMap. Call 'values' to get an iterator.
function corefchainannotation(doc::Annotation)
    return narrow(jcall(doc.jannotation, "get", JObject, (JClass,), JCorefChainAnnotationClass))
end

##Returns iterable list of tokens in an annotated sentence.
function tokens(sentence::JAnnotation)
    return narrow(jcall(sentence, "get", JObject, (JClass,), JTokensAnnotationClass))
end

##Returns a collection of relation triples from an annotated sentence.
function relationtriples(sentence::JAnnotation)
    return narrow(jcall(sentence, "get", JObject, (JClass,), JRelationTriplesAnnotationClass))
end

##Returns a LabeledScoredTreeNode object, the syntactic parse tree of a sentence.
function labeledscoredtreenode(sentence::JAnnotation)
    return narrow(jcall(sentence, "get", JObject, (JClass,), JTreeAnnotationClass))
end

##Returns a SemanticGraph.
function basicdependencies(sentence::JAnnotation)
    return narrow(jcall(sentence, "get", JObject, (JClass,), JBasicDependenciesAnnotationClass))
end

##Returns a SemanticGraph.
function collapseddependencies(sentence::JAnnotation)
    return narrow(jcall(sentence, "get", JObject, (JClass,), JCollapsedDependenciesAnnotationClass))
end

##Returns a SemanticGraph.
function collapsedccprocesseddependencies(sentence::JAnnotation)
    return narrow(jcall(sentence, "get", JObject, (JClass,), JCollapsedCCProcessedDependenciesAnnotationClass))
end

##Returns an iterable set of edu.stanford.nlp.coref.data.Mention.
function corefmentionsannotation(sentence::JAnnotation)
    return narrow(jcall(sentence, "get", JObject, (JClass,), JCorefMentionsAnnotationClass))
end

##Returns Sentiment
function sentimentannotation(sentence::JAnnotation)
    return narrow(jcall(sentence, "get", JObject, (JClass,), JSentimentAnnotatedTreeClass))
end


##Performs the annotation in place.
function annotate!(pipeline::StanfordCoreNLP, doc::Annotation)
    jcall(pipeline.jstanfordcorenlp, "annotate", Void, (JAnnotation,), doc.jannotation)
end
#------------------------------------------------------------------------------#



#=============================java.util.HashMap================================#
#https://docs.oracle.com/javase/7/docs/api/java/util/HashMap.html
#
function values(hashmap::JHashMap)
    return jcall(hashmap, "values", JCollection, ())
end
#------------------------------------------------------------------------------#



#==========================edu.stanford.nlp.coref.data.Mention=================#
function to_string(mention::JMention)
    return jcall(mention, "toString", JString, ())
end
#------------------------------------------------------------------------------#



#======edu.stanford.nlp.dcoref.CorefCoreAnnotations.CorefChainAnnotation=======#
function to_string(corefchain::JCorefChain)
    return jcall(corefchain, "toString", JString, ())
end
#------------------------------------------------------------------------------#



#================edu.stanford.nlp.trees.LabeledScoredTreeNode==================#
function children(jlstn::JLabeledScoredTreeNode)
    return jcall(jlstn, "children", JArray, ())  #Unsure of return type: JArray? JList? JCollection?
end

##Returns a Set of Constituents generated by the parse tree.
function constituents(jlstn::JLabeledScoredTreeNode)
    return jcall(jlstn, "constituents", JSet, ())
end
#------------------------------------------------------------------------------#



#====================edu.stanford.nlp.trees.Constituent========================#
#"A Constituent object defines a generic edge in a graph."
#https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/trees/Constituent.html
#
function to_string(constituent::JConstituent)
    return jcall(constituent, "toString", JString, ())
end
#------------------------------------------------------------------------------#



#===================edu.stanford.nlp.ie.util.RelationTriple====================#
#"A (subject, relation, object) triple."
#https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/ie/util/RelationTriple.html
#
##The subject of this relation triple, as a String
function subjectGloss(triple::JRelationTriple)
    return jcall(triple, "subjectGloss", JString, ())
end

##The object of this relation triple, as a String
function objectGloss(triple::JRelationTriple)
    return jcall(triple, "objectGloss", JString, ())
end

##The relation of this relation triple, as a String
function relationGloss(triple::JRelationTriple)
    return jcall(triple, "relationGloss", JString, ())
end

##The subject lemma of this relation triple, as a String
function subjectLemmaGloss(triple::JRelationTriple)
    return jcall(triple, "subjectLemmaGloss", JString, ())
end

##The object lemma of this relation triple, as a String
function objectLemmaGloss(triple::JRelationTriple)
    return jcall(triple, "objectLemmaGloss", JString, ())
end

##The relation lemma of this relation triple, as a String
function relationLemmaGloss(triple::JRelationTriple)
    return jcall(triple, "relationLemmaGloss", JString, ())
end

##Returns a JList of JCoreLabels that represent the given relation triple as a flat sentence.
function asSentence(triple::JRelationTriple)
    return jcall(triple, "asSentence", JList, ())
end

##If true, this relation expresses a "to be" relation.
function isPrefixBe(triple::JRelationTriple)
    return jcall(triple, "isPrefixBe", jboolean, ())
end

##If true, this relation expresses a "to be" relation (with the be at the end of the sentence).
function isSuffixBe(triple::JRelationTriple)
    return jcall(triple, "	isSuffixBe", jboolean, ())
end

##If true, this relation has an ungrounded "of" at the end of the relation.
function isSuffixOf(triple::JRelationTriple)
    return jcall(triple, "	isSuffixOf", jboolean, ())
end

##Returns human-readable description of this relation triple, as a tab-separated line.
function to_string(triple::JRelationTriple)
    return jcall(triple, "toString", JString, ())
end
#------------------------------------------------------------------------------#



#====================edu.stanford.nlp.ling.CoreLabel===========================#
##"A CoreLabel represents a single word with ancillary information attached using
##CoreAnnotations. A CoreLabel also provides convenient methods to access tags,
##lemmas, etc. (if the proper annotations are set). A CoreLabel is a Map from keys
##(which are Class objects) to values, whose type is determined by the key."
##https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/ling/CoreLabel.html
##
#WRAPPER
type CoreLabel
    token::JCoreLabel
    index::Int
    lemma::String
    pos::String
    ner::String
    originaltext::String
    word::String
    value::String
end

#CONSTRUCTORS
function CoreLabel(token::JCoreLabel)
    index = jcall(token, "index", jint, ())
    lemma = jcall(token, "lemma", JString, ())
    pos = jcall(token, "tag", JString, ())
    ner = jcall(token, "ner", JString, ())
    originaltext = jcall(token, "originalText", JString, ())
    word = jcall(token, "word", JString, ())
    value = jcall(token, "value", JString, ())
    return CoreLabel(token, index, lemma, pos, ner, originaltext, word, value)
end

#CONVENIENCE METHODS
##Converts a JCoreLabel object to String.
function to_string(token::JCoreLabel)
    return jcall(token, "toString", JString, ())
end

##Converts the .token field of a CoreLabel object to String.
function to_string(corelabel::CoreLabel)
    return jcall(corelabel.jcorelabel, "toString", JString, ())
end
#------------------------------------------------------------------------------#



#=======================edu.stanford.nlp.trees.Tree============================#
#WRAPPER
type Tree
    jtree::JTree
    size::jint
    depth::jint
    constituents::JSet
    iterator::JIterator
end

#CONSTRUCTORS
function Tree(jtree::JTree)
    size = jcall(tree, "size", jint, ())
    depth = jcall(tree, "depth", jint, ())
    constituents = jcall(tree, "constituents", JString, ())
    iterator = jcall(tree, "iterator", JString, ())
    return(jtree, size, depth, constituents, iterator)
end

#CONVENIENCE METHODS
##Converts parse tree to string in Penn Treebank format.
function to_string(jtree::JTree)
    return jcall(jtree, "toString", JString, ())
end

##Converts the .jtree field of the Tree wrapper to string in Penn Treebank format.
function to_string(tree::Tree)
    return jcall(tree.jtree, "toString", JString, ())
end

function to_string(jlstn::JLabeledScoredTreeNode)
    return jcall(jlstn, "toString", JString, ())
end

##Converts parse tree to string in Penn Treebank format.
function pennstring(jtree::JTree)
    return jcall(jtree, "pennString", JString, ())
end

##Converts parse tree to string in Penn Treebank format.
function pennstring(tree::Tree)
    return jcall(tree.jtree, "pennString", JString, ())
end

#Returns a list of children (trees) for the current node.
function getChildrenAsList(jlstn::JLabeledScoredTreeNode) #JTree?
    return jcall(jlstn, "getChildrenAsList", JList, ())
end
#------------------------------------------------------------------------------#



#=================edu.stanford.nlp.tagger.maxent.MaxentTagger==================#
##The main class for users to run, train, and test the part of speech tagger.
##https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/tagger/maxent/MaxentTagger.html
##
##WRAPPER
#=
type MaxentTagger
    jmet::JMaxentTagger
end

##CONSTRUCTORS
##Path is the location of parameter files for a trained tagger.
function MaxentTagger(path::AbstractString)
    jmet = JMaxentTagger((JString,), path)
    return MaxentTagger(jmet)
end

##List<TaggedWord> tagged = tagger.tagSentence(sentence)
function tagsentence(tagger::MaxentTagger, sentence::JList)
    jcall(tagger.jmet, "tagSentence", JList, (JList,), sentence)
end
=#
#------------------------------------------------------------------------------#



#edu.stanford.nlp.semgraph.SemanticGraph=======================================#
#"Represents a semantic graph of a sentence or document, with IndexedWord objects for nodes."
#https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/semgraph/SemanticGraph.html
#SemanticGraph's used mainly to represent dependencies.

#Convert SemanticGraph to String
function to_string(semgraph::JSemanticGraph)
    jcall(semgraph, "toString", JString, ())
end

#Convert SemanticGraph to list.
function to_list(semgraph::JSemanticGraph)
    return jcall(semgraph, "toList", JString, ())
end

function size(semgraph::JSemanticGraph)
    return jcall(semgraph, "size", jint, ())
end

function typedDependencies(semgraph::JSemanticGraph)
    return jcall(semgraph, "typedDependencies", JCollection, ())
end
#------------------------------------------------------------------------------#



#===============edu.stanford.nlp.parser.nndep.DependencyParser=================#
#Unused in `function test' as of Oct 2, 2017
#
#DependencyParser parser = DependencyParser.loadFromModelFile(modelPath);

function dependency_parser(modelPath::AbstractString)
    return narrow(jcall(JDependencyParser, "loadFromModelFile",
                                JDependencyParser, (JString,), modelPath))
end

#GrammaticalStructure gs = parser.predict(tagged);
function predict(parser::JDependencyParser , tagged::JList)
    jcall(parser, "predict", JGrammaticalStructure, (JList,), tagged)
end

function to_string(gs::JGrammaticalStructure)
    return jcall(gs, "toString", JString, ())
end

#------------------------------------------------------------------------------#



#===================edu.stanford.nlp.trees.TypedDependency=====================#
#"A TypedDependency is a relation between two words in a GrammaticalStructure.
#Each TypedDependency consists of a governor word, a dependent word, and a
#relation, which is normally an instance of GrammaticalRelation."
#https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/trees/TypedDependency.html
#
function to_string(typeddependency::JTypedDependency)
    return jcall(typeddependency, "toString", JString, ())
end
#------------------------------------------------------------------------------#



#============================java.io.StringReader==============================#
#Unused in `function test' as of Oct 2, 2017
#=
type StringReader
    jsr::JStringReader
end

function StringReader(text::AbstractString)
    jsr = JStringReader((JString,), text)
    return StringReader(jsr)
end
=#
#------------------------------------------------------------------------------#



#=================edu.stanford.nlp.process.DocumentPreprocessor================#
#Unused in `function test' as of Oct 2, 2017
#
#=
type DocumentPreprocessor
    jdp::JDocumentPreprocessor
end

function DocumentPreprocessor(stringreader::StringReader)
    jdp = JDocumentPreprocessor((JReader,), stringreader.jsr)
    return DocumentPreprocessor(jdp)
end
=#
#------------------------------------------------------------------------------#



#==============edu.stanford.nlp.parser.lexparser.LexicalizedParser=============#
#https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/parser/lexparser/LexicalizedParser.html
#
#WRAPPER
type LexicalizedParser
    jlp::JLexicalizedParser
end

#CONSTRUCTORS
function LexicalizedParser(parserFile::String)
    jlp = JLexicalizedParser((JString,), parserFile)
    return LexicalizedParser(jlp)
end

#CONVENIENCE METHODS
function load_lexalized_parser_model()
    return jcall(JLexicalizedParser, "loadModel", JLexicalizedParser, ())
end

#Parse sentence::JList to JTree using lp::JLexicalizedParser
function lexparse(lp::JLexicalizedParser, sentence::JAnnotation)
    return jcall(lp, "apply", JTree, (JAnnotation,), sentence)
end

#Convert Tree to String
function to_string(parse_tree::JTree)
    jcall(parse_tree, "toString", JString, ())
end
#------------------------------------------------------------------------------#
