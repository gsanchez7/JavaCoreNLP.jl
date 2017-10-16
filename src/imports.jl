#TYPES
##java.util
JArray = @jimport java.util.Array
JArrayList = @jimport java.util.ArrayList
JCollection = @jimport java.util.Collection
JHashMap = @jimport java.util.HashMap
JIterator = @jimport java.util.Iterator
JList = @jimport java.util.List
JProperties = @jimport java.util.Properties
JSet = @jimport java.util.Set

##java.io
#JReader = @jimport java.io.Reader
#JStringReader = @jimport java.io.StringReader

##edu.stanford.nlp.ling
JCoreLabel = @jimport edu.stanford.nlp.ling.CoreLabel

##edu.stanford.nlp.pipeline
JAnnotation = @jimport edu.stanford.nlp.pipeline.Annotation
JStanfordCoreNLP = @jimport edu.stanford.nlp.pipeline.StanfordCoreNLP

##edu.stanford.nlp.trees
JTree = @jimport edu.stanford.nlp.trees.Tree
JLabeledScoredTreeNode = @jimport edu.stanford.nlp.trees.LabeledScoredTreeNode
JConstituent = @jimport edu.stanford.nlp.trees.Constituent
JGrammaticalStructure = @jimport edu.stanford.nlp.trees.GrammaticalStructure
JTypedDependency = @jimport edu.stanford.nlp.trees.TypedDependency
#JTreeAnnotation = @jimport edu.stanford.nlp.trees.TreeCoreAnnotations.TreeAnnotation

##edu.stanford.nlp.parser
JDependencyParser = @jimport edu.stanford.nlp.parser.nndep.DependencyParser
JLexicalizedParser = @jimport edu.stanford.nlp.parser.lexparser.LexicalizedParser

##edu.stanford.nlp.coref
JCorefCoreAnnotations = @jimport edu.stanford.nlp.coref.CorefCoreAnnotations
JCorefChain = @jimport edu.stanford.nlp.coref.data.CorefChain
JMention = @jimport edu.stanford.nlp.coref.data.Mention

##Misc.
JSemanticGraph = @jimport edu.stanford.nlp.semgraph.SemanticGraph
JRelationTriple = @jimport edu.stanford.nlp.ie.util.RelationTriple
#JDocumentPreprocessor = @jimport edu.stanford.nlp.process.DocumentPreprocessor
#JNaturalLogicAnnotations = @jimport edu.stanford.nlp.naturalli.NaturalLogicAnnotations
#JMaxentTagger = @jimport edu.stanford.nlp.tagger.maxent.MaxentTagger



#CLASSES
## For sentence, token, and tree annotations
JSentencesAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$SentencesAnnotation")
JTokensAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$TokensAnnotation")
JTreeAnnotationClass = classforname("edu.stanford.nlp.trees.TreeCoreAnnotations\$TreeAnnotation")

##For dependency annotation
JBasicDependenciesAnnotationClass = classforname("edu.stanford.nlp.semgraph.SemanticGraphCoreAnnotations\$BasicDependenciesAnnotation") #inner? outer?
JCollapsedDependenciesAnnotationClass = classforname("edu.stanford.nlp.semgraph.SemanticGraphCoreAnnotations\$CollapsedDependenciesAnnotation") #inner? outer?
JCollapsedCCProcessedDependenciesAnnotationClass = classforname("edu.stanford.nlp.semgraph.SemanticGraphCoreAnnotations\$CollapsedCCProcessedDependenciesAnnotation")

##For coreference annotation
JCorefMentionsAnnotationClass = classforname("edu.stanford.nlp.coref.CorefCoreAnnotations\$CorefMentionsAnnotation")
JCorefChainAnnotationClass = classforname("edu.stanford.nlp.coref.CorefCoreAnnotations\$CorefChainAnnotation")
JRelationTriplesAnnotationClass = classforname("edu.stanford.nlp.naturalli.NaturalLogicAnnotations\$RelationTriplesAnnotation")

##For sentiment analysis
JSentimentAnnotatedTreeClass = classforname("edu.stanford.nlp.sentiment.SentimentCoreAnnotations\$SentimentAnnotatedTree")
