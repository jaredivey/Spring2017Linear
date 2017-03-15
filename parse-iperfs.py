import os

fileDir = "logs/iperfs"
for parseFile in os.listdir(fileDir):
    if parseFile.endswith(".log"):
        print parseFile

        parsedFile = "parsed-%s" % parseFile
        with open(fileDir+"/"+parseFile,'r') as rHandle:
            with open(fileDir+"/parsed/"+parsedFile,'w') as wHandle:
                newLine = ""
                prep = 0
                index = 0
                for line in rHandle:
                    if line == "------------------------------------------------------------\n":
                        prep += 1

                    if prep == 2:
                        if index != 0 and index % 3 == 0:
                            lineArray = line.split()
                            interval = lineArray[2]
                            transmitTime = interval.split('-')[1]

                            transmitAmount = lineArray[4]
                            transmitRate = lineArray[6]
                            jitter = lineArray[8]
                            lostDatagrams = lineArray[10].strip('/')
                            totalDatagrams = lineArray[11]
                            newLine = newLine + transmitTime + "\t" + transmitAmount + "\t" + transmitRate + "\t" \
                                      + jitter + "\t"+ lostDatagrams + "\t"+ totalDatagrams + "\t"

                        index += 1

                    if prep == 3:
                        prep = 1
                        index = 0
                        newLine = newLine + '\n'
                        wHandle.write(newLine)
                        newLine = ""
                newLine += "\n"
                #print newLine
                wHandle.write(newLine)
                newLine = ""
