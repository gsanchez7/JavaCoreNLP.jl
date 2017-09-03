using JavaCoreNLP

modelPath = "/home/john/.julia/v0.5/JavaCoreNLP/jvm/corenlp-wrapper/target/edu/stanford/nlp/models/parser/nndep/english_UD.gz"
taggerPath = "/home/john/.julia/v0.5/JavaCoreNLP/jvm/corenlp-wrapper/target/edu/stanford/nlp/models/pos-tagger/english-left3words/english-left3words-distsim.tagger";

text = "I can almost always tell when movies use fake dinosaurs. This is a second sentence.  And this is a third and final sentence."

tagger = MaxentTagger(taggerPath)
parser = DependencyParser(modelPath)
stringreader  = StringReader(text)
tokenizer = DocumentPreprocessor(stringreader)

for sentence in JavaCall.iterator(tokenizer.jdp)
    s = convert(JList, sentence)
    tagged = tagSentence(tagger, s)
    gs = predict(parser, tagged)
    #read out gs
end

println("Complete.")
