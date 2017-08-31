module JavaCoreNLP

export
    Annotation,
    StanfordCoreNLP,
    annotate!,
    test1,
    MaxentTagger,
    DependencyParser,
    Document,
    StringReader,
    DocumentPreprocessor,
    tagSentence,
    predict

include("core.jl")

end # module
