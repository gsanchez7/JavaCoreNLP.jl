using JavaCall

include("init.jl")
include("imports.jl")
include("macros.jl")
include("./data/annotators.jl")
include("Java_wrappers.jl")

#====================================demo======================================#
#Demonstrates annotation and information extraction using a flexible pipeline
#and covering most annotators.
function demo(pipeline::StanfordCoreNLP, text::String)

    #Get annotators used in this pipeline.
    props = get_properties(pipeline)
    annCSVString = get_property(props, "annotators")

    #Perform annotation.
    if !isempty(annCSVString)
        doc = Annotation(text)
        annotate!(pipeline, doc);
    else
        println("core.jl:25. Empty annotator list.")
        return
    end

    if ismatch(r"ssplit", annCSVString)

        #Iterate over sentences.
        sents = sentences(doc)
        for sent in JavaCall.iterator(sents)

            ##Iterate over tokens.
            if ismatch(r"tokenize", annCSVString)
                println("\nTokens=========")
                tokenlist = tokens(sent)
                for token in JavaCall.iterator(tokenlist)
                    cl = CoreLabel(token)
                    @printf "index=%4i  word=%10s  lemma=%10s  pos=%10s  ner=%10s \n" cl.index cl.word cl.lemma cl.pos cl.ner
                end
            end

            ##Parse tree.
            if ismatch(r"parse", annCSVString)
                println("\nParse tree=========")
                parse_tree = convert(JTree, labeledscoredtreenode(sent))
                println(pennstring(parse_tree))
            end

            ##Dependency semantic graphs.
            if ismatch(r"depparse", annCSVString)
                println("\nDependencies=========")
                println(to_string(basicdependencies(sent)))
                println(to_string(collapseddependencies(sent)))
                println(to_string(collapsedccprocesseddependencies(sent)))
                println(to_string(basicdependencies(sent)))
                println(to_string(collapseddependencies(sent)))
                println(to_string(collapsedccprocesseddependencies(sent)))
            end

            ##Relation triples.
            if ismatch(r"openie", annCSVString)
                println("\nRelations Triples=========")
                triples = relationtriples(sent)
                for triple in JavaCall.iterator(triples)
                    triple = convert(JRelationTriple, triple)
                    println(to_string(triple))
                    @printf "subject = %s.   Relation = %s.  Object = %s.\n" subjectGloss(triple) relationGloss(triple) objectGloss(triple)
                    @printf "subject = %s.   Relation = %s.  Object = %s.\n" subjectLemmaGloss(triple) relationLemmaGloss(triple) objectLemmaGloss(triple)
                end
            end

            ##Mentions
            if ismatch(r"mention", annCSVString)
                println("\nMentions=========")
                mentions = corefmentionsannotation(sent)
                for mention in JavaCall.iterator(mentions)
                    println(to_string(mention))
                end
            end

            if ismatch(r"sentiment", annCSVString)
                println("\nSentiment=========")
                sentiment = convert(JTree, sentimentannotation(sent))
                println(pennstring(sentiment))
            end
        end
    end

    #CorefChain's
    if ismatch(r"coref", annCSVString)
        println("\nCoref Chains=========")
        corefchains = values(corefchainannotation(doc))
        for corefchain in JavaCall.iterator(corefchains)
            println(to_string(corefchain))
        end
    end
end
