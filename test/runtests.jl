using JavaCoreNLP
using Base.Test

# write your own tests here
@test 1 == 1

text = "Japanese Prime Minister Shinzo Abe called the launch a serious and grave
            threat to his country, a key U.S. ally in the region. Analysts said
            the situation over North Korea remains a concern for investors."

test(text, "parse", "dcoref", "depparse")

println("Complete.")
