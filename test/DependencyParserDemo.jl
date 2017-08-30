using JavaCoreNLP
using Base.Test

println("DPD: 4")

modelPath = "/home/john/.julia/v0.5/JavaCoreNLP/jvm/corenlp-wrapper/target/edu/stanford/nlp/models/parser/nndep/english_UD.gz"
taggerPath = "/home/john/.julia/v0.5/JavaCoreNLP/jvm/corenlp-wrapper/target/edu/stanford/nlp/models/pos-tagger/english-left3words/english-left3words-distsim.tagger";

text = "I can almost always tell when movies use fake dinosaurs."

println("DPD: 11")
tagger = MaxentTagger(taggerPath)
println("DPD: 13")
#parser = DependencyParser(modelPath)
#
#
#parser = DependencyParser()
println("DPD: 18")

parser = DependencyParser(modelPath)
println("DPD: 21")

#taggedsentences = MaxentTagger(tagger, )
println("Complete.")
