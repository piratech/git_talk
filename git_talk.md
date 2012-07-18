# GIT - Distributed Version Control

---
# Was ist Versionskontrolle?
 * Dokumentation von Veränderung von Dateien über der Zeit
 * Wiederherstellbarkeit früherer Versionen <br>
   ⇒ „If you skrew things up […], you can easily recover“ – *pro GIT*
 * Simpelste Form der Versionskontrolle: Kopiere über Zwischenversionen
   von Dateien in ein „Backup“-Verzeichnis

---
# Zentrale Versionskontrollsysteme (CVCS)
 * z. B. CVS, Subversion, Perforce
 * ein zentrales Repository, Clients checken Dateien von dort aus und
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
