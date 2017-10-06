#=========================Test different text lengths.=========================#
using JavaCoreNLP
include("./data/texts.jl")
#using Base.Test

#UNCOMMENT ONE TO SELECT AN ANNOTATION PIPELINE.
    ##pipeline = StanfordCoreNLP("tokenize")                #ok
    ##pipeline = StanfordCoreNLP("ssplit")                  #ok
    ##pipeline = StanfordCoreNLP("pos")                     #ok
    ##pipeline = StanfordCoreNLP("lemma")                   #ok
    ##pipeline = StanfordCoreNLP("parse")                   #ok
    ##pipeline = StanfordCoreNLP("ner")                     #ok
    ##pipeline = StanfordCoreNLP("depparse")                #ok
    pipeline = StanfordCoreNLP("coref")                   #ok
    ##pipeline = StanfordCoreNLP("mention")                 #ok
    ##pipeline = StanfordCoreNLP("ner", "coref", "openie")  #ok

##UNCOMMENT ONE TO SELECT A TEXT.
    ##text = short_text     #21 words
    text = medium_text    #106 words
    ##text = long_text      #553 words

#Main function call.
    demo(pipeline, text)

#Report time consumed by each annotator in the pipeline.
    println("\n", timinginformation(pipeline))

#Report done.
    println("\nComplete.")
