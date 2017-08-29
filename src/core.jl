using JavaCall

include("init.jl")
include("java.jl")
include("utils.jl")
include("pipeline.jl")
include("analysis.jl")

function my_test(text::String, annotators::String...)
#function my_test()
    #pipeline = Pipeline(annotators...)
    println("core: 16")
    #doc = Annotation(text)
    println("core: 19")
    path = "/home/john/.julia/v0.5/JavaCoreNLP/jvm/corenlp-wrapper/target/edu/stanford/nlp/models/pos-tagger/english-left3words/english-left3words-distsim.tagger"
    met = MaxentTagger(path)
    #annotate!(pipeline, doc)
    println("core: 21")

    sentences = Sentences(doc)
    for sentence in JavaCall.iterator(sentences)
        tokens = Tokens(sentence)
        for token in JavaCall.iterator(tokens)
            lemma = Lemma(token)
            pos = POS(token)
            ne = NER(token)
            str = ToString(token)
            value = Value(token)
            word = Word(token)
            println("lemma= $lemma  pos= $pos  ne= $ne  str= $str  value= $value  word= $word")
        end
    end
end



# A very quick introduction to JavaCall:
#
# 1. Import class and give it a name in Julia:
#
#      JProperties = @jimport java.util.Properties
#      JStanfordCoreNLP = @jimport edu.stanford.nlp.pipeline.StanfordCoreNLP
#
# 2. Create an instance of this class:
#
#      jprops = JProperties(())
#      corenlp = JStanfordCoreNLP((JProperties), jprops)
#
#    The 1st argument is a tuple of types of this constructor, the rest
#    are actual arguments(instances of other classes)
#
# 3. Call a method of this instance
#
#      jcall(jprops, "setProperty", JObject, (JString, JString), "foo", "bar")
#
#    The arguments are:
#
#      * jprops - instance of Java class or class itself
#      * "setProperty" - name of a method
#      * JObject - return type
#      * (JString, JString) - tuple of method argument types
#      * key, value - actual arguments
#
# See more in official docs: http://juliainterop.github.io/JavaCall.jl/
