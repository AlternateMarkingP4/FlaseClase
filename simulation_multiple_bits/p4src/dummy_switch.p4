#include "includes/headers.p4"
#include "includes/parser.p4"
#include "includes/intrinsic.p4"

metadata ingress_intrinsic_metadata_t intrinsic_metadata;

register prev_color_reg_1 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_2 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_3 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_4 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_5 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_6 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_7 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_8 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_9 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_10 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_11 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_12 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_13 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_14 {
    width: 8;
    instance_count: 1;
}
register prev_color_reg_15 {
    width: 8;
    instance_count: 1;
}

register ts_sent_reg {
    width: 64;
    instance_count: 2;
}

register ts_recv_reg {
    width: 64;
    instance_count: 2;
}

counter sent_counter {
    type: packets;
    static: modify_flags;
    instance_count: 2;
}

/* Added counter for the use of switch 4
 * in order to count incoming packets. */
counter recv_counter {
    type: packets;
    static: read_flags;
    instance_count: 2;
}

/* Timestamp counter added as dummy when syntax requires val usage. */
counter ts_counter_send {
    type: packets;
    static: modify_ts_send;
    instance_count: 2;
}
counter ts_counter_recv {
    type: packets;
    static: modify_ts_recv;
    instance_count: 2;
}

/* -------------  ACTIONS -------------------------------------------------- */

action _drop() {
    drop();
}

action _set_port(dst) {
    modify_field(standard_metadata.egress_spec,dst);
}

/* Used only for sending (switch 1) for counting sent packets and updating
 * color history. */
action _modify_flags(val) {

    /* This take effect in the loss calculation sending (switch 1) part. */
    count(sent_counter,val);
    modify_field(ipv4.flag_a, val);

    /* This take effect in the delay calculation sending (switch 1) part. */
    register_read(intrinsic_metadata.prev_color_15, prev_color_reg_14, 0);
    register_read(intrinsic_metadata.prev_color_14, prev_color_reg_13, 0);
    register_read(intrinsic_metadata.prev_color_13, prev_color_reg_12, 0);
    register_read(intrinsic_metadata.prev_color_12, prev_color_reg_11, 0);
    register_read(intrinsic_metadata.prev_color_11, prev_color_reg_10, 0);
    register_read(intrinsic_metadata.prev_color_10, prev_color_reg_9, 0);
    register_read(intrinsic_metadata.prev_color_9, prev_color_reg_8, 0);
    register_read(intrinsic_metadata.prev_color_8, prev_color_reg_7, 0);
    register_read(intrinsic_metadata.prev_color_7, prev_color_reg_6, 0);
    register_read(intrinsic_metadata.prev_color_6, prev_color_reg_5, 0);
    register_read(intrinsic_metadata.prev_color_5, prev_color_reg_4, 0);
    register_read(intrinsic_metadata.prev_color_4, prev_color_reg_3, 0);
    register_read(intrinsic_metadata.prev_color_3, prev_color_reg_2, 0);
    register_read(intrinsic_metadata.prev_color_2, prev_color_reg_1, 0);
    modify_field(intrinsic_metadata.prev_color_1, val);

    register_write(prev_color_reg_15, 0, intrinsic_metadata.prev_color_15);
    register_write(prev_color_reg_14, 0, intrinsic_metadata.prev_color_14);
    register_write(prev_color_reg_13, 0, intrinsic_metadata.prev_color_13);
    register_write(prev_color_reg_12, 0, intrinsic_metadata.prev_color_12);
    register_write(prev_color_reg_11, 0, intrinsic_metadata.prev_color_11);
    register_write(prev_color_reg_10, 0, intrinsic_metadata.prev_color_10);
    register_write(prev_color_reg_9, 0, intrinsic_metadata.prev_color_9);
    register_write(prev_color_reg_8, 0, intrinsic_metadata.prev_color_8);
    register_write(prev_color_reg_7, 0, intrinsic_metadata.prev_color_7);
    register_write(prev_color_reg_6, 0, intrinsic_metadata.prev_color_6);
    register_write(prev_color_reg_5, 0, intrinsic_metadata.prev_color_5);
    register_write(prev_color_reg_4, 0, intrinsic_metadata.prev_color_4);
    register_write(prev_color_reg_3, 0, intrinsic_metadata.prev_color_3);
    register_write(prev_color_reg_2, 0, intrinsic_metadata.prev_color_2);
    register_write(prev_color_reg_1, 0, intrinsic_metadata.prev_color_1);
}

/* Used only bby receiving side. Read the color bit (flag_a) from the ipv4
 * header and count. Increase counter accordingly and update history. */
action _read_flags(val) {
    count(recv_counter,val);
    /* This take effect in the delay calculation sending (switch 1) part. */
    register_read(intrinsic_metadata.prev_color_15, prev_color_reg_14, 0);
    register_read(intrinsic_metadata.prev_color_14, prev_color_reg_13, 0);
    register_read(intrinsic_metadata.prev_color_13, prev_color_reg_12, 0);
    register_read(intrinsic_metadata.prev_color_12, prev_color_reg_11, 0);
    register_read(intrinsic_metadata.prev_color_11, prev_color_reg_10, 0);
    register_read(intrinsic_metadata.prev_color_10, prev_color_reg_9, 0);
    register_read(intrinsic_metadata.prev_color_9, prev_color_reg_8, 0);
    register_read(intrinsic_metadata.prev_color_8, prev_color_reg_7, 0);
    register_read(intrinsic_metadata.prev_color_7, prev_color_reg_6, 0);
    register_read(intrinsic_metadata.prev_color_6, prev_color_reg_5, 0);
    register_read(intrinsic_metadata.prev_color_5, prev_color_reg_4, 0);
    register_read(intrinsic_metadata.prev_color_4, prev_color_reg_3, 0);
    register_read(intrinsic_metadata.prev_color_3, prev_color_reg_2, 0);
    register_read(intrinsic_metadata.prev_color_2, prev_color_reg_1, 0);
    modify_field(intrinsic_metadata.prev_color_1, val);

    register_write(prev_color_reg_15, 0, intrinsic_metadata.prev_color_15);
    register_write(prev_color_reg_14, 0, intrinsic_metadata.prev_color_14);
    register_write(prev_color_reg_13, 0, intrinsic_metadata.prev_color_13);
    register_write(prev_color_reg_12, 0, intrinsic_metadata.prev_color_12);
    register_write(prev_color_reg_11, 0, intrinsic_metadata.prev_color_11);
    register_write(prev_color_reg_10, 0, intrinsic_metadata.prev_color_10);
    register_write(prev_color_reg_9, 0, intrinsic_metadata.prev_color_9);
    register_write(prev_color_reg_8, 0, intrinsic_metadata.prev_color_8);
    register_write(prev_color_reg_7, 0, intrinsic_metadata.prev_color_7);
    register_write(prev_color_reg_6, 0, intrinsic_metadata.prev_color_6);
    register_write(prev_color_reg_5, 0, intrinsic_metadata.prev_color_5);
    register_write(prev_color_reg_4, 0, intrinsic_metadata.prev_color_4);
    register_write(prev_color_reg_3, 0, intrinsic_metadata.prev_color_3);
    register_write(prev_color_reg_2, 0, intrinsic_metadata.prev_color_2);
    register_write(prev_color_reg_1, 0, intrinsic_metadata.prev_color_1);
}

action _modify_ts_send(val) {
    count(ts_counter_send, val);
    register_write(ts_sent_reg, 0, intrinsic_metadata.time_of_day);
}

action _modify_ts_recv(val) {
    count(ts_counter_recv, val);
    register_write(ts_recv_reg, 0, intrinsic_metadata.time_of_day);
}

/* ------------- TABLES ----------------------------------------------------- */

/* Routing table - has nothing to do with the algorithm, simply get the packets
 * from switch 1 to switch 4 and later on to the receiver. May choose from 
 * which inner switch (2 or 3) to go by. */
table set_port {
    reads {
        intrinsic_metadata.time_of_day : ternary;
	standard_metadata.ingress_port : exact;		
    }
    actions {
        _set_port;
        _drop;
    }
    size: 256;
}

/* Change the flag (single bit used for the algorithm) to fit the time. One may
 * change the digit that decides in power of 2 range in the switch 4
 * commands.txt file. */
table modify_flags {
    reads {
        intrinsic_metadata.time_of_day : ternary;
	ipv4.dstAddr : exact;	
    }
    actions {
        _modify_flags;
        _drop;
    }
    size: 256;
}

/* Added a table for switch 4 to use. */
table read_flags {
    reads {	
	ipv4.flag_a : exact;
	ipv4.srcAddr : exact;
    }
    actions {
        _read_flags;
        _drop;
    }
    size: 256;
}

table modify_ts_send {
    reads {
        intrinsic_metadata.prev_color_1 : exact;
        intrinsic_metadata.prev_color_2 : exact;
        intrinsic_metadata.prev_color_3 : exact;
        intrinsic_metadata.prev_color_4 : exact;
        intrinsic_metadata.prev_color_5 : exact;
        intrinsic_metadata.prev_color_11 : exact;
        intrinsic_metadata.prev_color_12 : exact;
        intrinsic_metadata.prev_color_13 : exact;
        intrinsic_metadata.prev_color_14 : exact;
        intrinsic_metadata.prev_color_15 : exact;
    }
    actions {
	_modify_ts_send;
        _drop;
    }
    size: 256;
}

table modify_ts_recv {
    reads {
        intrinsic_metadata.prev_color_1 : exact;
        intrinsic_metadata.prev_color_2 : exact;
        intrinsic_metadata.prev_color_3 : exact;
        intrinsic_metadata.prev_color_4 : exact;
        intrinsic_metadata.prev_color_5 : exact;
        intrinsic_metadata.prev_color_11 : exact;
        intrinsic_metadata.prev_color_12 : exact;
        intrinsic_metadata.prev_color_13 : exact;
        intrinsic_metadata.prev_color_14 : exact;
        intrinsic_metadata.prev_color_15 : exact;
    }
    actions {
	_modify_ts_recv;
        _drop;
    }
    size: 256;
}

/* -------------- CONTROLS ------------------------------------------------- */

control ingress {
	apply(modify_flags);
	apply(read_flags);
	apply(set_port);
}

control egress {
	apply(modify_ts_send);
	apply(modify_ts_recv);
}



