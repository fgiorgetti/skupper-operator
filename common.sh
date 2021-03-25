function waitRunning() {
    ns=$1; shift
    pod=$1; shift
    echo Waiting on ${pod} to be running at ${ns}
    while ! bash -c "kubectl -n ${ns} get pods | egrep ${pod}.*[1-9]\/[1-9].*Running"; do
        sleep 1
    done
}

function waitRemoved() {
    ns=$1; shift
    pod=$1; shift
    echo Waiting on ${pod} to be deleted from ${ns}
    while bash -c "kubectl -n ${ns} get pods | egrep ${pod}"; do
        sleep 1
    done
}

