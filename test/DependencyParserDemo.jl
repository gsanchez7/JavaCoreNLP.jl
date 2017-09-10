using JavaCoreNLP

pkgDirPath = Pkg.Dir.path()
println("pkgDirPath = $pkgDirPath")
modelPath = string(pkgDirPath, "/JavaCoreNLP/jvm/corenlp-wrapper/target/edu/stanford/nlp/models/parser/nndep/english_UD.gz")
taggerPath = string(pkgDirPath, "/JavaCoreNLP/jvm/corenlp-wrapper/target/edu/stanford/nlp/models/pos-tagger/english-left3words/english-left3words-distsim.tagger")

text = "I can almost always tell when movies use fake dinosaurs. This is a second sentence.  And this is a third and final sentence."

tagger = MaxentTagger(taggerPath)
parser = DependencyParser(modelPath)
stringreader = StringReader(text)
tokenizer = DocumentPreprocessor(stringreader)

for sentence in JavaCall.iterator(tokenizer.jdp)
    println("New sentence=========")
    tagged = tagSentence(tagger, convert(JList, sentence))
    gs = predict(parser, tagged)
    stringGS = GrammaticalStructureToString(gs)
    println("stringGS = $stringGS")
    println(" ")
end

println("Complete.")
