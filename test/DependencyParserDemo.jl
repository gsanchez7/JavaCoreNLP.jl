using JavaCoreNLP
using Base.Test

println("DPD: 4")

modelPath = "/home/john/.julia/v0.5/JavaCoreNLP/jvm/corenlp-wrapper/target/edu/stanford/nlp/models/parser/nndep/english_UD.gz"
taggerPath = "/home/john/.julia/v0.5/JavaCoreNLP/jvm/corenlp-wrapper/target/edu/stanford/nlp/models/pos-tagger/english-left3words/english-left3words-distsim.tagger";

text = "I can almost always tell when movies use fake dinosaurs."

tagger = MaxentTagger(taggerPath)
println("DPD: 12")

parser = DependencyParser(modelPath)
println("DPD: 15")

stringreader  = StringReader(text)
println("DPD: 18")

tokenizer = DocumentPreprocessor(stringreader)
println("DPD: 20")

for sentence in JavaCall.iterator(tokenizer)
    tagged = tagSentence(sentence)
    println("DPD: 23")
    gs = predict(tagged)
    println("DPD: 25")
    #print something out.
end

println("Complete.")
