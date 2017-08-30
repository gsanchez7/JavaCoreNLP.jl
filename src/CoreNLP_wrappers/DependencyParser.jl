#=============================================================================
edu.stanford.nlp.parser.nndep.DependencyParser methods
https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/parser/nndep/DependencyParser.html

A generic call is built as follows--
jcall(A, B, C, D) where--
   A is a CoreLabel and in practice, a token.
   B is a key associated with the desired value.
   C is 'JString', the return type.
   D is '()'. These calls take no arguments.

For example, in,
   'jcall(token, "lemma", JString, ())'
the 'lemma' key maps to a lemma JString (the value).
=============================================================================#


type DependencyParser
    jdp::JDependencyParser
end

#function DependencyParser(modelPath::AbstractString)
function DependencyParser()
    jdp = JDependencyParser(())  #Constructor is DependencyParser(Properties properties). Must allow properties = void.
    return DependencyParser(jdp)
end

#=
function DependencyParser(parser::DependencyParser, modelPath::AbstractString)
    return narrow(jcall(parser.jdp, "loadFromModelFile", JObject, (JString,), modelPath))
end
=#

function DependencyParser(modelPath::AbstractString)
    return narrow(jcall(JDependencyParserClass, "loadFromModelFile", JObject, (JString,), modelPath))
end
