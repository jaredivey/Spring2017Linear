#! /bin/bash
ssh jivey@pc2.instageni.rnoc.gatech.edu -p 31036 "sudo ovs-vsctl set bridge br0 other_config:datapath-id=0000000000000001"
ssh jivey@pc2.instageni.rnoc.gatech.edu -p 31037 "sudo ovs-vsctl set bridge br0 other_config:datapath-id=0000000000000002"
ssh jivey@pc1.instageni.rnoc.gatech.edu -p 31038 "sudo ovs-vsctl set bridge br0 other_config:datapath-id=0000000000000003"
ssh jivey@pc2.instageni.rnoc.gatech.edu -p 31038 "sudo ovs-vsctl set bridge br0 other_config:datapath-id=0000000000000004"
ssh jivey@pc5.instageni.rnoc.gatech.edu -p 31037 "sudo ovs-vsctl set bridge br0 other_config:datapath-id=0000000000000005"
ssh jivey@pc2.instageni.rnoc.gatech.edu -p 31039 "sudo ovs-vsctl set bridge br0 other_config:datapath-id=0000000000000006"
ssh jivey@pc1.instageni.rnoc.gatech.edu -p 31039 "sudo ovs-vsctl set bridge br0 other_config:datapath-id=0000000000000007"
ssh jivey@pc5.instageni.rnoc.gatech.edu -p 31038 "sudo ovs-vsctl set bridge br0 other_config:datapath-id=0000000000000008"
