build:
    ./scripts/build_iso.sh
    
test:
    ./scripts/build_iso.sh test
    ./scripts/run_iso.sh install
    ./scripts/run_iso.sh
    