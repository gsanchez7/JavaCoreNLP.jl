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

#DependencyParser parser = DependencyParser.loadFromModelFile(modelPath);
function DependencyParser(modelPath::AbstractString)
    return narrow(jcall(JDependencyParser, "loadFromModelFile", JDependencyParser, (JString,), modelPath))
end


#DocumentPreprocessor tokenizer = new DocumentPreprocessor(new StringReader(text));

type StringReader
    jsr::JStringReader
end

function StringReader(text::AbstractString)
    jsr = JStringReader((JString,), text)
    return StringReader(jsr)
end

#function StringReader(text::AbstractString)
#    return JStringReader((JString,), text)
#end

type DocumentPreprocessor
    jdp::JDocumentPreprocessor
end

function DocumentPreprocessor(stringreader::StringReader)
    jdp = JDocumentPreprocessor((JStringReader,), stringreader.jsr)
    return DocumentPreprocessor(jdp)
end

#List<TaggedWord> tagged = tagger.tagSentence(sentence)
function tagSentence(sentence::JHasWord)
    jcall(tagger, "tagSentence", JArrayList, (JHasWord,), sentence)
end

#GrammaticalStructure gs = parser.predict(tagged);
function predict(tagged::JArrayList)
    jcall(parser, "predict", JGrammaticalStructure, (JArrayList,), tagged)
end
