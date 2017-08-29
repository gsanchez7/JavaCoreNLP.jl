#=============================================================================
edu.stanford.nlp.ling.CoreLabel methods
https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/ling/CoreLabel.html

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


#Returns the lemma value of the label (or null if none).
function Lemma(token::JCoreLabel)
    return jcall(token, "lemma", JString, ())
end


#Returns the tag value of the label (or null if none).
function POS(token::JCoreLabel)
    return jcall(token, "tag", JString, ())
end


#Returns the named entity class of the label (or null if none).
function NER(token::JCoreLabel)
    return jcall(token, "ner", JString, ())
end


#Return the String which is the original character sequence of the token.
function OriginalText(token::JCoreLabel)
    return jcall(token, "originalText", JString, ())
end


#Return the word value of the label (or null if none).
function Word(token::JCoreLabel)
    return jcall(token, "word", JString, ())
end


#Prints a full dump of a CoreMap.
function ToString(token::JCoreLabel)
    return jcall(token, "toString", JString, ())
end


#Not implemented. See CoreLabelTokenFactory(boolean addIndices) to add this.
function Index(token::JCoreLabel)
    return jcall(token, "index", JString, ())
end


#Returns a String representation of just the "main" value of this label.
function Value(token::JCoreLabel)
    return jcall(token, "value", JString, ())
end
