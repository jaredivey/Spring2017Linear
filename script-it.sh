#! /bin/bash

###############################################################################
# Zero flow tests
###############################################################################
for num in {1..20}
do
    bash run-pings-no-flows.sh python ss simple_switch_13 n 0 auto
done
for num in {1..20}
do
    bash run-pings-no-flows.sh python fws fw_simple n 0 auto
done
for num in {1..20}
do
    bash run-pings-no-flows.sh python ns-bfs nix_simple_bfs n 0 auto
done
for num in {1..20}
do
    bash run-pings-no-flows.sh python ns-ucs nix_simple_ucs n 0 auto
done
#for num in {1..20}
#do
#    bash run-pings-no-flows.sh python nm-bfs nix_mpls_bfs y 0 auto
#done
#for num in {1..20}
#do
#    bash run-pings-no-flows.sh python nm-ucs nix_mpls_ucs y 0 auto
#done
#for num in {1..20}
#do
#    bash run-pings-no-flows.sh java fl-nix nix unused 0 auto
#done
for num in {1..20}
do
    bash run-pings-no-flows.sh java fl-def empty unused 0 auto
done
bash swapFloodlightConfig.sh floodlightdefault.properties learningswitch.properties
for num in {1..20}
do
    bash run-pings-no-flows.sh java fl-l2s empty unused 0 auto
done
bash swapFloodlightConfig.sh floodlightdefault.properties learningswitch.properties

###############################################################################
# One flow tests
###############################################################################
for num in {1..20}
do
    bash run-pings-1-flow.sh python ss simple_switch_13 n 1 auto
done
for num in {1..20}
do
    bash run-pings-1-flow.sh python fws fw_simple n 1 auto
done
for num in {1..20}
do
    bash run-pings-1-flow.sh python ns-bfs nix_simple_bfs n 1 auto
done
for num in {1..20}
do
    bash run-pings-1-flow.sh python ns-ucs nix_simple_ucs n 1 auto
done
#for num in {1..20}
#do
#    bash run-pings-1-flow.sh python nm-bfs nix_mpls_bfs y 1 auto
#done
#for num in {1..20}
#do
#    bash run-pings-1-flow.sh python nm-ucs nix_mpls_ucs y 1 auto
#done
#for num in {1..20}
#do
#    bash run-pings-1-flow.sh java fl-nix nix unused 1 auto
#done
for num in {1..20}
do
    bash run-pings-1-flow.sh java fl-def empty unused 1 auto
done
bash swapFloodlightConfig.sh floodlightdefault.properties learningswitch.properties
for num in {1..20}
do
    bash run-pings-1-flow.sh java fl-l2s empty unused 1 auto
done
bash swapFloodlightConfig.sh floodlightdefault.properties learningswitch.properties

###############################################################################
# Two flow tests
###############################################################################
for num in {1..20}
do
    bash run-pings-2-flows.sh python ss simple_switch_13 n 2 auto
done
for num in {1..20}
do
    bash run-pings-2-flows.sh python fws fw_simple n 2 auto
done
for num in {1..20}
do
    bash run-pings-2-flows.sh python ns-bfs nix_simple_bfs n 2 auto
done
for num in {1..20}
do
    bash run-pings-2-flows.sh python ns-ucs nix_simple_ucs n 2 auto
done
#for num in {1..20}
#do
#    bash run-pings-2-flows.sh python nm-bfs nix_mpls_bfs y 2 auto
#done
#for num in {1..20}
#do
#    bash run-pings-2-flows.sh python nm-ucs nix_mpls_ucs y 2 auto
#done
#for num in {1..20}
#do
#    bash run-pings-2-flows.sh java fl-nix nix unused 2 auto
#done
for num in {1..20}
do
    bash run-pings-2-flows.sh java fl-def empty unused 2 auto
done
bash swapFloodlightConfig.sh floodlightdefault.properties learningswitch.properties
for num in {1..20}
do
    bash run-pings-2-flows.sh java fl-l2s empty unused 2 auto
done
bash swapFloodlightConfig.sh floodlightdefault.properties learningswitch.properties


###############################################################################
# Three flow tests
###############################################################################

for num in {1..20}
do
    bash run-pings-3-flows.sh python ss simple_switch_13 n 3 auto
done
for num in {1..20}
do
    bash run-pings-3-flows.sh python fws fw_simple n 3 auto
done
for num in {1..20}
do
    bash run-pings-3-flows.sh python ns-bfs nix_simple_bfs n 3 auto
done
for num in {1..20}
do
    bash run-pings-3-flows.sh python ns-ucs nix_simple_ucs n 3 auto
done
#for num in {1..20}
#do
#    bash run-pings-3-flows.sh python nm-bfs nix_mpls_bfs y 3 auto
#done
#for num in {1..20}
#do
#    bash run-pings-3-flows.sh python nm-ucs nix_mpls_ucs y 3 auto
#done
#for num in {1..20}
#do
#    bash run-pings-3-flows.sh java fl-nix nix unused 3 auto
#done
for num in {1..20}
do
    bash run-pings-3-flows.sh java fl-def empty unused 3 auto
done
bash swapFloodlightConfig.sh floodlightdefault.properties learningswitch.properties
for num in {1..20}
do
    bash run-pings-3-flows.sh java fl-l2s empty unused 3 auto
done
bash swapFloodlightConfig.sh floodlightdefault.properties learningswitch.properties
