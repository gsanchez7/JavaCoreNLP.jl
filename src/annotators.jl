#Annotators and their dependencies.
#See https://stanfordnlp.github.io/CoreNLP/dependencies.html
ANNOTATORS = Dict(
    "tokenize" => String[],
    "cleanxml" => ["tokenize"],
    "ssplit" => ["tokenize"],
    "pos" => ["tokenize", "ssplit"],
    "lemma" => ["tokenize", "ssplit", "pos"],
    "ner" => ["tokenize", "ssplit", "pos", "lemma"],
    "regexner" => String[],
    "sentiment" => String[],
    "parse" => ["tokenize", "ssplit"],
    "depparse" => ["tokenize", "ssplit", "pos"],
    "dcoref" => ["tokenize", "ssplit", "pos", "lemma", "ner", "parse"],
    "relation" => ["tokenize", "ssplit", "pos", "lemma", "ner", "depparse"],
    "natlog" => ["tokenize", "ssplit", "pos", "lemma", "depparse"],
    "qquote" => String[]
)
