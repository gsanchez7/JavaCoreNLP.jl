using JavaCoreNLP

#Use Base.@__DIR__ for base of relative path.  But not supported in v0.5.
#println("@__FILE__ = ", Base.@__FILE__)

modelPath = Pkg.dir("JavaCoreNLP", "jvm", "corenlp-wrapper", "target", "edu",
            "stanford", "nlp", "models", "parser", "nndep", "english_UD.gz")
taggerPath = Pkg.dir("JavaCoreNLP", "jvm", "corenlp-wrapper", "target", "edu",
            "stanford", "nlp", "models", "pos-tagger", "english-left3words",
            "english-left3words-distsim.tagger")

text = "I can almost always tell when movies use fake dinosaurs.
            This is a second sentence.
                        And this is a third and final sentence."

tagger = MaxentTagger(taggerPath)
parser = dependency_parser(modelPath)
stringreader = StringReader(text)
tokenizer = DocumentPreprocessor(stringreader)

for sentence in JavaCall.iterator(tokenizer.jdp)
    println("New sentence=========")

    sentence = convert(JList, sentence)
    taggedsentence = tagsentence(tagger, sentence)
    for taggedword in JavaCall.iterator(taggedsentence)
        println("word = $(word(taggedword))    pos = $(tag(taggedword))")
    end

    gs = predict(parser, taggedsentence)
    stringGS = to_string(gs)
    println("stringGS = $stringGS")
    println(" ")
end

println("Complete.")
