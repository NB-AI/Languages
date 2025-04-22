
#filename = "data-00_000.seq.raw"
with open(filename, 'r') as fh:
    file_content = fh.read()

def count_bases_and_subsequence(data_as_string: str, subsequence: str):
    string = "" # leerer string. wir starten mit einem leeren string. dieser wird nachher mit inhalten der zweiten spalte gefüllt
    for line in data_as_string.split('\n'): # jede zeile bei splitung
        if line == '# Data end': # wenn zeile diesen inhalt, dann wird die schleife abgebrochen
            break
        elif line.startswith('#') == True or len(line) == 0: # wenn zeile mit # startet oder keinen inhalt hat, fortfahren ohne Beachtung
            string += "_" # platzhalter _ # dieser sorgt dafür, dass die Zeilen trotz continue nicht ignoriert werden, da dies zuerst ausgefürht wird.
                                          # dadurch zählen unterbrochene ATTC nicht mehr als ATTC
            continue
        columns = line.split(";") # spalten werden definiert durch aufsplittung durch ;
        if float(columns[2]) < 0.05: # wenn 3. Spalte kleiner als 0.05 ist, dann die zeile als platzhalter eingelesen
            string += "_"
        else:
            string += columns[1].lower() # ansonsten wird der inhalt der zweiten spalte absofort kleingeschrieben
    a_count = string.count("a") # für jede Zeile werden die strings a gezählt, zweite spalte wurde eine zeile darüber als "string" bezeichnet
    g_count = string.count("g")
    c_count = string.count("c")
    t_count = string.count("t")
    resultdict = {"a":a_count, "g":g_count, "c":c_count, "t":t_count} # Ziel war, alles in einem dictionary festzuhalten
    subsequence_count = string.count(subsequence.lower()) # hier zählt man willkürliche Subsequenzen, die alle kleingeschrieben sind, wie oben definiert
    return resultdict, subsequence_count

count_bases_and_subsequence(file_content, "ATTC") # hier ruft man nochmal die funktion auf, das erste argument bezieht sich auf data_as_string, sprich
# die for-schleife, die zeile für zeile in spalten aufgegliedert eingelesen wird.
# das zweite argument ist ein string "ATTC", der als Beispiel des allgemeinen Arguments subsequence dient. in der funktion selbst, wurden noch beliebige
# funktionen gezählt. nun soll spezifisch "ATTC" gezählt werden.
# Ob ATTC nun groß oder klein geschrieben ist, spielt keine rolle
