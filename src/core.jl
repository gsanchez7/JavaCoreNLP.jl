using JavaCall

include("init.jl")
include("utils.jl")
include("Java_wrappers.jl")
include("pipeline.jl")


function test(text::String, annotators::String...)

    #Construct pipeline and perform annotation.
    pline = pipeline(annotators...)
    doc = Annotation(text)
    annotate!(pline, doc)

    #Interrogate the annotated doc.
    sentencelist = sentences(doc)
    for sentence in JavaCall.iterator(sentencelist)
        println("New sentence=========")
        tokenlist = tokens(sentence)
        #Interrogate CoreLabel's
        for token in JavaCall.iterator(tokenlist)
            lem = lemma(token)
            pos = tag(token)
            ne = ner(token)
            str = to_string(token)
            val = value(token)
            wrd = word(token)
            println("lem= $lem  pos= $pos  ne= $ne  str= $str  val= $val  wrd= $wrd")
        end #for token

        #Interrogage SemanticGraph's
        semgraph = semanticgraph(sentence)
        semgraph_list = sg_list(semgraph)
        semgraph_size = sg_size(semgraph)
        println("semgraph_size = ", semgraph_size)
        println("semgraph_list = ", semgraph_list)

    end #for sentence
end #function
