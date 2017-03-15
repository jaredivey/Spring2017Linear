import os

fileDir = "logs/tcpdumps"
for parseFile in os.listdir(fileDir):
    if parseFile.endswith(".log"):
        print parseFile

        parsedFile = "parsed-%s" % parseFile
        with open(fileDir+"/"+parseFile,'r') as rHandle:
            with open(fileDir+"/parsed/"+parsedFile,'w') as wHandle:
                newLine = ""
                for line in rHandle:
                    lineArray = line.split()

                    if len(lineArray) <= 1:
                        continue

                    if lineArray[0] == "tcpdump:":
                        newLine += "\n"
                        #print newLine
                        wHandle.write(newLine)
                        newLine = ""

                    if lineArray[1] == "packets":
                        newLine = newLine + lineArray[0] + "\t"                
                newLine += "\n"
                #print newLine
                wHandle.write(newLine)
                newLine = ""
