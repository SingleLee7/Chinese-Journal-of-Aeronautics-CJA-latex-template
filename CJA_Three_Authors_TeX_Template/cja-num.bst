% CJA author-side numbered bibliography style.
% Original style, not an Elsevier production style.
ENTRY {author title journal booktitle year volume number pages publisher
       organization address edition doi note} {} {}
INTEGERS {nameptr numnames namesleft}
STRINGS {s t result}
FUNCTION {and}
{ { skip$ } { pop$ #0 } if$ }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
  "" 'result :=
  { namesleft #0 > nameptr #7 < and }
  { s nameptr "{vv~}{ll}{~}{f{}}" format.name$ 't :=
    nameptr #1 > {result ", " * 'result :=} 'skip$ if$
    result t * 'result :=
    nameptr #1 + 'nameptr :=
    namesleft #1 - 'namesleft :=
  } while$
  numnames #6 > {result ", et~al" * 'result :=} 'skip$ if$
  result
}
FUNCTION {authors}
{ author empty$ {"Anonymous"} {author format.names} if$ }
FUNCTION {journal.name}
{ journal 's :=
  s "IEEE Wireless Communications Letters" = {"IEEE Wirel Commun Lett" 's :=} 'skip$ if$
  s "IEEE Transactions on Wireless Communications" = {"IEEE Trans Wirel Commun" 's :=} 'skip$ if$
  s "IEEE Internet of Things Journal" = {"IEEE Internet Things J" 's :=} 'skip$ if$
  s "IEEE Communications Surveys \& Tutorials" = {"IEEE Commun Surv Tutor" 's :=} 'skip$ if$
  s "IEEE Communications Letters" = {"IEEE Commun Lett" 's :=} 'skip$ if$
  s "IEEE Communications Magazine" = {"IEEE Commun Mag" 's :=} 'skip$ if$
  s "IEEE Transactions on Aerospace and Electronic Systems" = {"IEEE Trans Aerosp Electron Syst" 's :=} 'skip$ if$
  s "IEEE Transactions on Communications" = {"IEEE Trans Commun" 's :=} 'skip$ if$
  s "IEEE Transactions on Signal Processing" = {"IEEE Trans Signal Process" 's :=} 'skip$ if$
  s "IEEE Transactions on Vehicular Technology" = {"IEEE Trans Veh Technol" 's :=} 'skip$ if$
  s "IEEE Transactions on Antennas and Propagation" = {"IEEE Trans Antennas Propag" 's :=} 'skip$ if$
  s "IEEE Signal Processing Magazine" = {"IEEE Signal Process Mag" 's :=} 'skip$ if$
  s "Proceedings of the IEEE" = {"Proc IEEE" 's :=} 'skip$ if$
  s "IET Radar, Sonar \& Navigation" = {"IET Radar Sonar Navig" 's :=} 'skip$ if$
  s "Science China Information Sciences" = {"Sci China Inf Sci" 's :=} 'skip$ if$
  s "IEEE Journal on Selected Areas in Communications" = {"IEEE J Sel Areas Commun" 's :=} 'skip$ if$
  s
}
FUNCTION {begin.item}
{ newline$ "\bibitem{" write$ cite$ write$ "}" write$ newline$
  authors write$ ". " write$
  title "t" change.case$ write$ ". " write$
}
FUNCTION {finish.item}
{ note empty$ 'skip$ {" " write$ note write$ "." write$} if$
  newline$
}
FUNCTION {article}
{ begin.item
  journal.name write$ " " write$ year write$
  volume empty$
    { ". " write$ pages empty$ 'skip$ {"p. " write$ pages write$ "." write$} if$
      doi empty$ 'skip$ {" \doi{" write$ doi write$ "}." write$} if$ }
    { ";" write$ volume write$
      number empty$ 'skip$ {"(" write$ number write$ ")" write$} if$
      pages empty$ {"." write$} {":" write$ pages write$ "." write$} if$ }
  if$
  finish.item
}
FUNCTION {inproceedings}
{ begin.item
  "In: " write$ booktitle write$ ". " write$
  organization empty$ 'skip$ {organization write$ "; " write$} if$
  year write$ "." write$
  pages empty$ 'skip$ {" p. " write$ pages write$ "." write$} if$
  finish.item
}
FUNCTION {book}
{ begin.item
  edition empty$ 'skip$
    {edition "1" = {"1st ed. " write$} {edition write$ " ed. " write$} if$} if$
  address empty$ 'skip$ {address write$ ": " write$} if$
  publisher write$ "; " write$ year write$ "." write$
  finish.item
}
FUNCTION {misc}
{ begin.item year write$ "." write$
  doi empty$ 'skip$ {" \doi{" write$ doi write$ "}." write$} if$
  finish.item
}
FUNCTION {default.type} {misc}
FUNCTION {begin.bib}
{ "\begin{thebibliography}{99}" write$ newline$
  "\providecommand{\doi}[1]{\href{https://doi.org/#1}{doi:\nolinkurl{#1}}}" write$ newline$
}
FUNCTION {end.bib}
{ newline$ "\end{thebibliography}" write$ newline$ }
READ
EXECUTE {begin.bib}
ITERATE {call.type$}
EXECUTE {end.bib}
