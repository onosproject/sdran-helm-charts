# SPDX-FileCopyrightText: 2021-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

package aether_3_0_0

echo[config] {
    config := input
}

allowed[config] {
    ap_list := ap_lists # refer to rule below
    application := applications
    connectivity_service := connectivityservices
    device_group := devicegroups
    enterprise := enterprises
    ip_domain := ip_domains
    network := networks
    site := sites
    template := templates
    traffic_class := trafficclasses
    upf := upfs
    vcs := vcss
    config := {
        "ap-list": {
            "ap-list": [
                ap_list
            ]
        },
        "application": {
            "application": [
                application
            ]
        },
        "connectivity-service": {
            "connectivity-service": [
                connectivity_service
            ]
        },
        "device-group": {
            "device-group": [
                device_group
            ]
        },
        "enterprise": {
            "enterprise": [
                enterprise
            ]
        },
        "ip-domain": {
            "ip-domain": [
                ip_domain
            ]
        },
        "network": {
            "network": [
                network
            ]
        },
        "site": {
            "site": [
                site
            ]
        },
        "template": {
            "template": [
                template
            ]
        },
        "traffic_class": {
            "traffic_class": {
                traffic_class
            }
        },
        "upf": {
            "upf": [
                upf
            ]
        },
        "vcs": {
            "vcs": [
                vcs
            ]
        }
    }
}

ap_lists[ap_list] {
    ap_list := input.ap_list.ap_list[_]
    ["AetherROCAdmin", ap_list.enterprise][_] == input.groups[i]
}

applications[application] {
    application := input.application.application[_]
    ["AetherROCAdmin", application.enterprise][_] == input.groups[i]
}

connectivityservices[connectivity_service] {
    connectivity_service := input.connectivity_service.connectivity_service[_]
}

devicegroups[device_group] {
    device_group := input.device_group.device_group[_]
    site := sites
    device_group.site == site[_].id # allow only the device_groups of a known site
}

enterprises[enterprise] {
    enterprise := input.enterprise.enterprise[_]
    ["AetherROCAdmin", enterprise.id][_] == input.groups[i]
}

ip_domains[ip_domain] {
    ip_domain := input.ip_domain.ip_domain[_]
    ["AetherROCAdmin", ip_domain.enterprise][_] == input.groups[i]
}

networks[network] {
    network := input.network.network[_]
    ["AetherROCAdmin", network.enterprise][_] == input.groups[i]
}

sites[site] {
    site := input.site.site[_]
    ["AetherROCAdmin", site.enterprise][_] == input.groups[i]
}

templates[template] {
    template := input.template.template[_]
}

trafficclasses[traffic_class] {
    traffic_class := input.traffic_class.traffic_class[_]
}

upfs[upf] {
    upf := input.upf.upf[_]
    ["AetherROCAdmin", upf.enterprise][_] == input.groups[i]
}

vcss[vcs] {
    vcs := input.vcs.vcs[i]
    application := applications
    vcs.application[_].application == application[_].id
}

can_update_enterprise = true {
    update_enterprise := input.updates.enterprise.enterprise[_]
    ["AetherROCAdmin", update_enterprise.id][_] == input.groups[i]
}
