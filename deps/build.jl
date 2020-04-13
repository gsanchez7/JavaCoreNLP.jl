mvn = Sys.is_apple() ? "mvn.cmd" : "mvn"
which = Sys.is_apple() ? "where" : "which"

try
    run(`$which $mvn`)
catch
    error("Cannot find maven. Is it installed?")
end

cd("../jvm/corenlp-wrapper")
run(`$mvn clean package`)
