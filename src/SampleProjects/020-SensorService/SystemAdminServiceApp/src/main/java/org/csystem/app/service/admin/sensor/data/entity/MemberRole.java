package org.csystem.app.service.admin.sensor.data.entity;

import javax.persistence.*;

@Entity
@Table(name = "member_roles")
public class MemberRole {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_role_id")
    public int id;

    @Column(length = 50)
    public String role;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    public Member member;
}
