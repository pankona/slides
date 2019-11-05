# golangci-lint がサポートしている lint 一覧

golangci-lint がサポートしている linter 一覧は以下のコマンドで出力できる

```bash
$ golangci-lint help linters
```

出力結果は以下。40 個くらいあってめっちゃ多い...！

```
Enabled by default linters:
deadcode: Finds unused code [fast: true, auto-fix: false]
errcheck: Errcheck is a program for checking for unchecked errors in go programs. These unchecked errors can be critical bugs in some cases [fast: true, auto-fix: false]
gosimple (megacheck): Linter for Go source code that specializes in simplifying a code [fast: true, auto-fix: false]
govet (vet, vetshadow): Vet examines Go source code and reports suspicious constructs, such as Printf calls whose arguments do not align with the format string [fast: true, auto-fix: false]
ineffassign: Detects when assignments to existing variables are not used [fast: true, auto-fix: false]
staticcheck (megacheck): Staticcheck is a go vet on steroids, applying a ton of static analysis checks [fast: true, auto-fix: false]
structcheck: Finds unused struct fields [fast: true, auto-fix: false]
typecheck: Like the front-end of a Go compiler, parses and type-checks Go code [fast: true, auto-fix: false]
unused (megacheck): Checks Go code for unused constants, variables, functions and types [fast: false, auto-fix: false]
varcheck: Finds unused global variables and constants [fast: true, auto-fix: false]

Disabled by default linters:
bodyclose: checks whether HTTP response body is closed successfully [fast: true, auto-fix: false]
depguard: Go linter that checks if package imports are in a list of acceptable packages [fast: true, auto-fix: false]
dogsled: Checks assignments with too many blank identifiers (e.g. x, _, _, _, := f()) [fast: true, auto-fix: false]
dupl: Tool for code clone detection [fast: true, auto-fix: false]
funlen: Tool for detection of long functions [fast: true, auto-fix: false]
gochecknoglobals: Checks that no globals are present in Go code [fast: true, auto-fix: false]
gochecknoinits: Checks that no init functions are present in Go code [fast: true, auto-fix: false]
gocognit: Computes and checks the cognitive complexity of functions [fast: true, auto-fix: false]
goconst: Finds repeated strings that could be replaced by a constant [fast: true, auto-fix: false]
gocritic: The most opinionated Go source code linter [fast: true, auto-fix: false]
gocyclo: Computes and checks the cyclomatic complexity of functions [fast: true, auto-fix: false]
godox: Tool for detection of FIXME, TODO and other comment keywords [fast: true, auto-fix: false]
gofmt: Gofmt checks whether code was gofmt-ed. By default this tool runs with -s option to check for code simplification [fast: true, auto-fix: true]
goimports: Goimports does everything that gofmt does. Additionally it checks unused imports [fast: true, auto-fix: true]
golint: Golint differs from gofmt. Gofmt reformats Go source code, whereas golint prints out style mistakes [fast: true, auto-fix: false]
gosec (gas): Inspects source code for security problems [fast: true, auto-fix: false]
interfacer: Linter that suggests narrower interface types [fast: true, auto-fix: false]
lll: Reports long lines [fast: true, auto-fix: false]
maligned: Tool to detect Go structs that would take less memory if their fields were sorted [fast: true, auto-fix: false]
misspell: Finds commonly misspelled English words in comments [fast: true, auto-fix: true]
nakedret: Finds naked returns in functions greater than a specified function length [fast: true, auto-fix: false]
prealloc: Finds slice declarations that could potentially be preallocated [fast: true, auto-fix: false]
scopelint: Scopelint checks for unpinned variables in go programs [fast: true, auto-fix: false]
stylecheck: Stylecheck is a replacement for golint [fast: true, auto-fix: false]
unconvert: Remove unnecessary type conversions [fast: true, auto-fix: false]
unparam: Reports unused function parameters [fast: true, auto-fix: false]
whitespace: Tool for detection of leading and trailing whitespace [fast: true, auto-fix: true]
wsl: Whitespace Linter - Forces you to use empty lines! [fast: true, auto-fix: false]

Linters presets:
bugs: bodyclose, errcheck, gosec, govet, scopelint, staticcheck, typecheck
complexity: gocognit, gocyclo, nakedret
format: gofmt, goimports
performance: bodyclose, maligned, prealloc
style: depguard, dogsled, dupl, funlen, gochecknoglobals, gochecknoinits, goconst, gocritic, godox, golint, gosimple, interfacer, lll, misspell, stylecheck, unconvert, whitespace, wsl
unused: deadcode, ineffassign, structcheck, unparam, unused, varcheck
```