using sys

mvn = sys.is_windows() ? "mvn.cmd" : "mvn"
which = sys.is_windows() ? "where" : "which"

try
    run(`$which $mvn`)
catch
    error("Cannot find maven. Is it installed?")
end

cd("../jvm/corenlp-wrapper")
run(`$mvn clean package`)
