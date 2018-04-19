class vagrant() {

  lookup('puppet.includes').each |$value| { include "::vagrant::${value}" }

}
