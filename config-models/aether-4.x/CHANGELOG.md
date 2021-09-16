Differences from Aether-3.0.0

VCS and Template:
  * Containerized device MBR Uplink and Download to device.mbr.uplink and device.mbr.downlink
  * Added slice.mbr.uplink and slice.mbr.downlink
  * Remove link to AP-List
  * All bitrates are now uint64 and have units "bps"
	
Site:
  * Added link to AP-List
  * Now includes a list of access points
  * Small-cell (formerly access-point) list includes a name for each AP
	
Application:
  * Added mbr.uplink and mbr.downlink

Traffic-Class:
  * Removed pelr and pdb
  * Added arp

AP-List
  * Removed; contents added to slice

UPF:
  * Added config-endpoint
	
Models prefixed with onf- throughout.
