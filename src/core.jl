using JavaCall
include("init.jl")

println("core: 4")






println("core: 11")

JProperties = @jimport java.util.Properties
JStanfordCoreNLP = @jimport edu.stanford.nlp.pipeline.StanfordCoreNLP
JAnnotation = @jimport edu.stanford.nlp.pipeline.Annotation

JArrayList = @jimport java.util.ArrayList
JTree = @jimport edu.stanford.nlp.trees.Tree
JSemanticGraph = @jimport edu.stanford.nlp.semgraph.SemanticGraph
JCoreLabel = @jimport edu.stanford.nlp.ling.CoreLabel
JMaxentTagger = @jimport edu.stanford.nlp.tagger.maxent

println("core: 23")

#Java classes from Stanford NLP. Used for interrogating CoreMap and CoreLabel annotation results.
JSentencesAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$SentencesAnnotation")
JTokensAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$TokensAnnotation")
JTextAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$TextAnnotation")
JPartOfSpeechAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$PartOfSpeechAnnotation")
JNamedEntityTagAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$NamedEntityTagAnnotation")  #NEW
JTreeAnnotationClass = classforname("edu.stanford.nlp.trees.TreeCoreAnnotations\$TreeAnnotation")
JTreeClass = classforname("edu.stanford.nlp.trees.Tree") #TreeAnnotationClass?
JCollapsedCCProcessedDependenciesAnnotationClass = classforname("edu.stanford.nlp.semgraph.SemanticGraphCoreAnnotations\$CollapsedCCProcessedDependenciesAnnotation")
JCorefChainAnnotationClass = classforname("edu.stanford.nlp.dcoref.CorefCoreAnnotations\$CorefChainAnnotation")
JMaxentTaggerClass = classforname("edu.stanford.nlp.tagger.maxent.MaxentTagger") #Java.lang.ClassNotFoundException.  No $
JGrammaticalStructureClass = classforname("edu.stanford.nlp.trees.GrammaticalStructure") #Java.lang.ClassNotFoundException No $
JDependencyParserClass = classforname("edu.stanford.nlp.parser.nndep.DependencyParser") #Java.lang.ClassNotFoundException No $

println("core: 39")
include("utils.jl")
println("core: 41")
include("pipeline.jl")
println("core: 43")

function my_test()
    # example from https://stanfordnlp.github.io/CoreNLP/api.html
    pipeline = StanfordCoreNLP(Dict("annotations" =>
                                    "tokenize, ssplit, pos, lemma, ner, parse, dcoref"))
    doc = Annotation("The Beatles were an English rock band formed in Liverpool in 1960.")
    annotate!(pipeline, doc)
end



# A very quick introduction to JavaCall:
#
# 1. Import class and give it a name in Julia:
#
#      JProperties = @jimport java.util.Properties
#      JStanfordCoreNLP = @jimport edu.stanford.nlp.pipeline.StanfordCoreNLP
#
# 2. Create an instance of this class:
#
#      jprops = JProperties(())
#      corenlp = JStanfordCoreNLP((JProperties), jprops)
#
#    The 1st argument is a tuple of types of this constructor, the rest
#    are actual arguments(instances of other classes)
#
# 3. Call a method of this instance
#
#      jcall(jprops, "setProperty", JObject, (JString, JString), "foo", "bar")
#
#    The arguments are:
#
#      * jprops - instance of Java class or class itself
#      * "setProperty" - name of a method
#      * JObject - return type
#      * (JString, JString) - tuple of method argument types
#      * key, value - actual arguments
#
# See more in official docs: http://juliainterop.github.io/JavaCall.jl/
