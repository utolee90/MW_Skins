#
# a simple po to js converter by wkpark at kldp.org
#

BEGIN {
  msgid=""; msgstr="";
  print "/* automatically generated by make-js-trans.awk script */";
  print ("_translations = {");
  out="";
}

/^msgid "/ { #"{
  if (msgid && str) {
    gsub(/\$/, "\\$", str);
    out = sprintf ("%s%s\n", out, ("\"" msgid "\":\n   \"" str "\","));
  }
  str = substr ($0, 8, length ($0) - 8);
  msgstr="";
}

/^msgstr "/ { #"{
  msgid=str;
  str = substr ($0, 9, length ($0) - 9);
  next;
}

/^"/ { #"{
  str = (str substr ($0, 2, length ($0) - 2));
  next;
}

END {
  if (msgid && str) {
    gsub(/\$/, "\\$", str);
    out = sprintf ("%s%s", out, ("\"" msgid "\":\n   \"" str "\""));
  }
  gsub(/\,\n?$/, "", out);
  print out;
  print ("}\n");
}

