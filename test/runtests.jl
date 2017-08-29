using JavaCoreNLP
using Base.Test

# write your own tests here
@test 1 == 1

text = "Stocks in the U.S. and Asia dropped after North Korea fired a missile that flew over Japan.
South Korea's benchmark Kospi index fell 1% in morning Asian trading Tuesday, while Japan's Nikkei sank 0.8%.
Japanese Prime Minister Shinzo Abe called the launch a serious and grave threat to his country, a key U.S. ally in the region.
Analysts said the situation over North Korea remains a concern for investors."

my_test(text, "pos")

println("Complete.")
