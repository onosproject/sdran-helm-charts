# SPDX-FileCopyrightText: 2021-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

package aether_2_1_0

echo[config] {
    config := input
}

allowed[config] {
    access_profile := access_profiles # refer to rule below
    subscriber := subscribers
    apn_profile := apn_profiles
    connectivity_service := connectivityservices
    enterprise := enterprises
    qos_profile := qos_profiles
    security_profile := security_profiles
    service_profile := service_profiles
    service_group := service_groups
    service_policy := service_policies
    service_rule := service_rules
    up_profile := up_profiles
    config := {
        "access_profile": {
            "access_profile": [
                access_profile
            ]
        },
        "subscriber": {
            "ue": [
                subscriber
            ]
        },
        "apn_profile": {
            "apn_profile": [
                apn_profile
            ]
        },
        "connectivity-service": {
            "connectivity-service": [
                connectivity_service
            ]
        },
        "enterprise": {
            "enterprise": [
                enterprise
            ]
        },
        "qos_profile": {
            "qos_profile": [
                qos_profile
            ]
        },
        "security_profile": {
            "security_profile": [
                security_profile
            ]
        },
        "service_profile": {
            "service_profile": [
                service_profile
            ]
        },
        "service_group": {
            "service_group": [
                service_group
            ]
        },
        "service_policy": {
            "service_policy": [
                service_policy
            ]
        },
        "service_rule": {
            "service_rule": [
                service_rule
            ]
        },
        "up_profile": {
            "up_profile": [
                up_profile
            ]
        },
    }
}

access_profiles[access_profile] {
    access_profile := input.access_profile.access_profile[_]
}

subscribers[subscriber] {
    subscriber := input.subscriber.ue[_]
}

apn_profiles[apn_profile] {
    apn_profile := input.apn_profile.apn_profile[_]
}

connectivityservices[connectivity_service] {
    enterprise := input.enterprise.enterprise[_]
    enterprise_cs := enterprise.connectivity_service[_]
    connectivity_service := input.connectivity_service.connectivity_service[_]
    ["AetherROCAdmin", enterprise.id][_] == input.groups[i]
    enterprise_cs.connectivity_service == connectivity_service.id
}

enterprises[enterprise] {
    enterprise := input.enterprise.enterprise[_]
    ["AetherROCAdmin", enterprise.id][_] == input.groups[_]
}

qos_profiles[qos_profile] {
    qos_profile := input.qos_profile.qos_profile[_]
}
security_profiles[security_profile] {
    security_profile := input.security_profile.security_profile[_]
}
service_profiles[service_profile] {
    service_profile := input.service_profile.service_profile[_]
}
service_groups[service_group] {
    service_group := input.service_group.service_group[_]
}
service_policies[service_policy] {
    service_policy := input.service_policy.service_policy[_]
}
service_rules[service_rule] {
    service_rule := input.service_rule.service_rule[_]
}
up_profiles[up_profile] {
    up_profile := input.up_profile.up_profile[_]
}