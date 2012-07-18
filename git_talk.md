# Git - Distributed Version Control

---
# Was ist Versionskontrolle?
 + Dokumentation von Veränderung von Dateien über der Zeit
 + Wiederherstellbarkeit früherer Versionen <br>
   ⇒ „If you skrew things up […], you can easily recover“ – *pro Git*
 + Simpelste Form der Versionskontrolle: Kopiere über Zwischenversionen
   von Dateien in ein „Backup“-Verzeichnis

---
# Zentrale Versionskontrollsysteme (CVCS)
 + z. B. CVS, Subversion, Perforce
 + ein zentrales Repository, Clients checken Dateien von dort aus und
   commiten nach dort

 ![Zentrale Versionskontrolle](images/cvcs.png)

---
# Zentrale Versionskontrolle
## Vorteile
 + Jeder weiß, was jeder gerade tut
 + Administratoren können kontrolieren, wer was darf und wer was nicht

## Nachteile
 - Single Point of Failure
 - Verbindung zum zentralen Server ist zwingend notwendig

---
# Verteilte Versionskontrollsystem (DVCS)
 + z. B. Git, Mercurial, Bazaar
 + Clients checken Dateien nicht aus, sondern spiegeln das gesamte
   Repository

 ![Dezentrale Versionskontrolle](images/dvcs.png)

---
# Git – Eine kurze Geschichtsstunde
 + Linux-Kernel wurde bis 2002 mit Patchdateien via E-Mail
   versionskontrolliert
 + ab 2002: proprietäres DVCS BitKeeper
 + 2005: Anspannung der Beziehung zwischen Linux-Community und
   BitKeeper-Entwickler
   ⇒ Linus Torvald entwickelt als Wochenendprojekt Git als Alternative
 + Anforderungen:
    * Geschwindigkeit
    * Einfaches Design
    * Unterstützung nicht-linearer Entwicklung
    * komplett verteilt
    * Unterstützung sehr großer Projekte
