mvn = Sys.isunix() ? "mvn.cmd" : "mvn"
which = Sys.isunix() ? "where" : "which"

try
    run(`$which $mvn`)
catch
    error("Cannot find maven. Is it installed?")
end

cd("../jvm/corenlp-wrapper")
run(`$mvn clean package`)
