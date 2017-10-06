#Annotators and their dependencies.
#See https://stanfordnlp.github.io/CoreNLP/dependencies.html

#Value is an unordered list of *all* annotators required by the Key.
ANNOTATOR_DEPENDENCIES = Dict(
    "tokenize" => String[],
    "quote" => String[],
    "regexner" => String[],
    "cleanxml" => ["tokenize"],
    "ssplit" => ["tokenize"],
    "pos" => ["tokenize", "ssplit"],
    "lemma" => ["tokenize", "ssplit", "pos"],
    "ner" => ["tokenize", "ssplit", "pos", "lemma"],
    "parse" => ["tokenize", "ssplit", "pos"],
    "depparse" => ["tokenize", "ssplit", "pos"],
    "sentiment" => ["tokenize", "ssplit", "pos", "parse"],
    "natlog" => ["tokenize", "ssplit", "pos", "lemma", "depparse"],
    "dcoref" => ["tokenize", "ssplit", "pos", "lemma", "ner", "parse"],
    "relation" => ["tokenize", "ssplit", "pos", "lemma", "ner", "depparse"],
    "mention" => ["tokenize", "ssplit", "pos", "parse", "lemma", "ner", "depparse"],
    "coref" => ["tokenize", "ssplit", "pos", "parse", "lemma", "ner", "depparse", "mention"],
    "openie" => ["tokenize", "ssplit", "pos", "lemma", "depparse", "natlog"]
)

#Each annotator is to the right of its dependencies.
ORDERED_ANNOTATOR_LIST = ["tokenize", "regexner", "quote", "ssplit",
        "cleanxml", "pos", "lemma", "parse", "depparse", "sentiment", "ner",
        "natlog", "dcoref", "relation", "mention", "coref", "openie"]
