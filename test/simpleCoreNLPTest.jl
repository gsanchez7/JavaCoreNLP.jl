using JavaCoreNLP
using Base.Test

@test 1 == 1

text = "Japanese Prime Minister Shinzo Abe called the launch a serious and grave threat to his country, a key U.S. ally in the region.
Analysts said the situation over North Korea remains a concern for investors."

doc = Document(text)
sentences = Sentences(doc)
for sentence in JavaCall.iterator(sentences)

test1(text, "pos")

println("Complete.")
