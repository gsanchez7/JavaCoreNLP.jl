type Document
    jdoc::JDocument
end

function Document(text::AbstractString)
    jdoc = JDocument((JString,), text)
    return Document(jdoc)
end

#Returns a JArrayList of the sentences in the document.
function Sentences(doc::JDocument)
    return narrow(jcall(doc, "sentences", JObject, ()))
end

#a JArrayList of the lemmas of the sentence.
function Lemmas(sentence::JArrayList)
    return narrow(jcall(sentence, "lemmas", JObject, ()))
end

#Returns a JString of the lemma to a particular index.
function Lemmas(sentence::JArrayList, index::Int)
    return narrow(jcall(sentence, "lemmas", JObject, (jint), index))
end

#a  of the lemmas of the sentence.
function Lemmas(sentence::JArrayList)
    return narrow(jcall(sentence, "lemmas", JObject, ()))
end

#Returns a JArrayList of the part-of-speech tags of the sentence.
function posTag(sentence::JArrayList)
    return narrow(jcall(sentence, "lemmas", JObject, ()))
end

#Returns a JTree of the  constituency parse of the sentence.
function Parse(sentence::JArrayList)
    return narrow(jcall(sentence, "parse", JObject, ()))
end

#Returns the coreference chain for just this sentence: Map<Integer,CorefChain>.
function Coref(sentence::JArrayList)
    return narrow(jcall(sentence, "coref", JObject, ()))
end

#Returns the dependency graph of the sentence, as a raw SemanticGraph object.
function dependencyGraph(sentence::JArrayList)
    return narrow(jcall(sentence, "dependencyGraph", JObject, ()))
end

#Returns a JArrayList of the incoming dependency labels of the sentence according to the Basic Dependencies.
function incomingDependencyLabels(sentence::JArrayList)
    return narrow(jcall(sentence, "incomingDependencyLabels", JObject, ()))
end

#Returns a JString of the incoming dependency label to a particular index according to the Basic Dependencies.
function incomingDependencyLabels(sentence::JArrayList, index::Int)
    return narrow(jcall(sentence, "incomingDependencyLabels", JObject, (jint), index))
end
