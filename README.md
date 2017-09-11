 #Overview  
 *Provides a Julia interface to Stanford CoreNLP Natural language software.

 *Uses JavaCall to call CoreNLP directly. Does not require or use Python.

 *Implements the `Dependency Parser` demo and the `Stanford CoreNLP API` demo, links below.

#Key links  
[Stanford CoreNLP repo](https://stanfordnlp.github.io/CoreNLP/)  
[Stanford JavaNLP API Documentation](https://nlp.stanford.edu/nlp/javadoc/javanlp/index.html?overview-summary.html)  
[Dependency Parser Demo](https://github.com/stanfordnlp/CoreNLP/blob/master/src/edu/stanford/nlp/parser/nndep/demo/DependencyParserDemo.java)  
[API Demo](https://stanfordnlp.github.io/CoreNLP/api.html)  
[Web-based parser/tagger](http://nlp.stanford.edu:8080/parser/index.jsp)  
[Annotator dependencies](https://stanfordnlp.github.io/CoreNLP/dependencies.html)  
[Manning et al. paper](https://nlp.stanford.edu/pubs/StanfordCoreNlp2014.pdf)  
[JavaCall](https://github.com/JuliaInterop/JavaCall.jl)


#Short Introduction to JavaCall  
 1. Import class and give it a name in Julia:

      JProperties = @jimport java.util.Properties
      JStanfordCoreNLP = @jimport edu.stanford.nlp.pipeline.StanfordCoreNLP

 2. Create an instance of this class:

      jprops = JProperties(())
      corenlp = JStanfordCoreNLP((JProperties), jprops)

    The 1st argument is a tuple of types of this constructor, the rest
    are actual arguments(instances of other classes)

 3. Call a method of this instance

      jcall(jprops, "setProperty", JObject, (JString, JString), "foo", "bar")

    The arguments are:

      * jprops - instance of Java class or class itself
      * "setProperty" - name of a method
      * JObject - return type
      * (JString, JString) - tuple of method argument types
      * key, value - actual arguments


 See more in official docs: http://juliainterop.github.io/JavaCall.jl/
