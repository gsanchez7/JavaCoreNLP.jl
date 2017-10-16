#=====================Test different annotator pipelines.======================#
#Dependencies
    using JavaCoreNLP
    include("./data/texts.jl")
    #using Base.Test

#UNCOMMENT ONE TO SELECT AN ANNOTATION PIPELINE.
    ##pipeline = StanfordCoreNLP("tokenize")                #ok
    ##pipeline = StanfordCoreNLP("quote")                   #Runs to completion.
    ##pipeline = StanfordCoreNLP("sentiment")               #Runs to completion.
    ##pipeline = StanfordCoreNLP("ssplit")                  #ok
    ##pipeline = StanfordCoreNLP("pos")                     #ok
    ##pipeline = StanfordCoreNLP("lemma")                   #ok
    ##pipeline = StanfordCoreNLP("parse")                   #ok
    ##pipeline = StanfordCoreNLP("ner")                     #ok
    ##pipeline = StanfordCoreNLP("depparse")                #ok
    ##pipeline = StanfordCoreNLP("coref")                   #ok
    ##pipeline = StanfordCoreNLP("relation")                  #ok
    ##pipeline = StanfordCoreNLP("mention")                 #ok
    pipeline = StanfordCoreNLP("ner", "coref", "openie")  #ok

##UNCOMMENT ONE TO SELECT A TEXT.
    ##text = hitchhikers_text
    ##text = obama_text
    text = google_text
    ##text = happy_text
    ##text = subset_text_1
    ##text = instance_text_1

#Main function call.
    demo(pipeline, text)

#Report time consumed by each annotator in the pipeline.
    println("\n", timinginformation(pipeline))

#Report done.
    println("\nComplete.")
