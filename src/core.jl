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
    annList = get_property(props, "annotators")
    annList = convert(Array{String,1}, split(annList, ","))

    #Perform annotation.
    if !isempty(annList)
        doc = Annotation(text)
        annotate!(pipeline, doc);
    else
        println("core.jl:24. Empty annotator list.")
        return
    end

    #Iterate over sentences.
    if in("ssplit", annList)
        for sentence in @iter sentences(doc)

            ##Iterate over tokens.
            if in("tokenize", annList)
                println("\nTokens=========")
                tokenlist = tokens(sentence)
                for token in @iter tokenlist
                    cl = CoreLabel(token)
                    @printf "index=%4i  word=%10s  lemma=%10s  pos=%10s  ner=%10s \n" cl.index cl.word cl.lemma cl.pos cl.ner
                end
            end

            ##Parse tree.
            if in("parse", annList)
                println("\nParse tree=========")
                parse_tree = convert(JTree, labeledscoredtreenode(sentence))
                @print_penn parse_tree
            end

            ##Dependency semantic graphs.
            if in("depparse", annList)
                println("\nDependencies=========")
                @print_string basicdependencies(sentence)
                @print_string collapseddependencies(sentence)
                @print_string collapsedccprocesseddependencies(sentence)
                @print_list basicdependencies(sentence)
                @print_list collapseddependencies(sentence)
                @print_list collapsedccprocesseddependencies(sentence)
            end

            ##Relation triples.
            if in("openie", annList)
                println("\nRelations Triples=========")
                triples = relationtriples(sentence)
                for triple in @iter triples
                    triple = convert(JRelationTriple, triple)
                    @print_string triple
                    @printf "subject = %s.   Relation = %s.  Object = %s.\n" subjectGloss(triple) relationGloss(triple) objectGloss(triple)
                    @printf "subject = %s.   Relation = %s.  Object = %s.\n" subjectLemmaGloss(triple) relationLemmaGloss(triple) objectLemmaGloss(triple)
                end
            end

            ##Mentions
            if in("mention", annList)
                println("Mentions=========")
                mentions = corefmentionsannotation(sentence)
                for mention in @iter mentions
                    @print_string mention
                end
            end

            if in("sentiment", annList)
                println("Sentiment=========")
                sentiment = convert(JTree, sentimentannotation(sentence))
                @print_penn sentiment
            end
        end #sentence in @iter sentences(doc)
    end #if in("ssplit", annList)

    #CorefChain's
    if in("coref", annList)
        println("\n Coref Chains=========")
        corefchains = values(corefchainannotation(doc))
        for corefchain in @iter corefchains
            @print_string corefchain
        end
    end

end
