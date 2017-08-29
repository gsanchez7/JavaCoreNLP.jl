#Java types
JStanfordCoreNLP = @jimport edu.stanford.nlp.pipeline.StanfordCoreNLP
JAnnotation = @jimport edu.stanford.nlp.pipeline.Annotation
JCoreLabel = @jimport edu.stanford.nlp.ling.CoreLabel
JArrayList = @jimport java.util.ArrayList
JTree = @jimport edu.stanford.nlp.trees.Tree
JSemanticGraph = @jimport edu.stanford.nlp.semgraph.SemanticGraph
JMaxentTagger = @jimport edu.stanford.nlp.tagger.maxent.MaxentTagger


#Java classes
##Inner
JSentencesAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$SentencesAnnotation")
JTokensAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$TokensAnnotation")
JTextAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$TextAnnotation")
JLemmaAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$LemmaAnnotation") #new
JPartOfSpeechAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$PartOfSpeechAnnotation")
JNamedEntityTagAnnotationClass = classforname("edu.stanford.nlp.ling.CoreAnnotations\$NamedEntityTagAnnotation")
JTreeAnnotationClass = classforname("edu.stanford.nlp.trees.TreeCoreAnnotations\$TreeAnnotation")
JTreeClass = classforname("edu.stanford.nlp.trees.Tree") #TreeAnnotationClass?
JCollapsedCCProcessedDependenciesAnnotationClass = classforname("edu.stanford.nlp.semgraph.SemanticGraphCoreAnnotations\$CollapsedCCProcessedDependenciesAnnotation")
JCorefChainAnnotationClass = classforname("edu.stanford.nlp.dcoref.CorefCoreAnnotations\$CorefChainAnnotation")

##Outer
JMaxentTaggerClass = classforname("edu.stanford.nlp.tagger.maxent.MaxentTagger")
JGrammaticalStructureClass = classforname("edu.stanford.nlp.trees.GrammaticalStructure")
JDependencyParserClass = classforname("edu.stanford.nlp.parser.nndep.DependencyParser")
