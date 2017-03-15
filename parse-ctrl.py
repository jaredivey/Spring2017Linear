import os

fileDir = "logs/ctrl"
for parseFile in os.listdir(fileDir):
    if parseFile.startswith("python") and parseFile.endswith(".log"):
        print parseFile

        parsedFile = "parsed-major-linear-2-%s" % parseFile
        with open(fileDir+"/"+parseFile,'r') as rHandle:
            with open(fileDir+"/parsed/"+parsedFile,'w') as wHandle:
                newLine = ""
                for line in rHandle:
                    lineArray = line.split()

                    if len(lineArray) <= 1:
                        continue

                    if lineArray[0] == "Cost:":
                    #    print lineArray[1]
                        continue

                    if lineArray[0] == "loading" or lineArray[0] == "instantiating" or lineArray[0] == "\n":
                        continue

                    if lineArray[0] == "LLDPLOOP" or lineArray[0] == "LINKLOOP":
                        continue

                    if lineArray[1] == "Starting":
                        continue

                    if lineArray[0] == "switches:" or lineArray[0] == "Traceback" or lineArray[0] == "File":
                        continue

                    if lineArray[0] == "KeyboardInterrupt" or lineArray[0] == "handler" or lineArray[0] == "if":
                        continue

                    if lineArray[0] == "del" or lineArray[0] == "return" or lineArray[1] == "None)":
                        continue

                    if len(lineArray) > 6 and lineArray[6] == "primitive" and (lineArray[0] == "ARP" or lineArray[0] == "PORTDESC" or lineArray[0] == "COMPLETION"):
                        newLine = lineArray[1] + "\t" + lineArray[5][1:] + "\n"
                        wHandle.write(newLine)
