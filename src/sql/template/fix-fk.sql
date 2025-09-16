alter table blg_taxregistration_amazon_pay drop
    constraint `fk_blg_taxregistration_amazon_pay_id` // 

alter table blg_taxregistration_amazon_pay add
    constraint `fk_blg_taxregistration_amazon_pay_id`
     foreign key (`id`) references `blg_hdr_amazon_pay` (`id`) on delete cascade on update cascade//

alter table blg_buyer_amazon_pay drop
    constraint `fk_blg_buyer_amazon_pay_id` // 

alter table blg_buyer_amazon_pay add
    constraint `fk_blg_buyer_amazon_pay_id`
     foreign key (`id`) references `blg_hdr_amazon_pay` (`id`) on delete cascade on update cascade//
alter table blg_seller_amazon_pay drop
    constraint `fk_blg_seller_amazon_pay_id` // 

alter table blg_seller_amazon_pay add
    constraint `fk_blg_seller_amazon_pay_id`
     foreign key (`id`) references `blg_hdr_amazon_pay` (`id`) on delete cascade on update cascade//



alter table blg_taxregistration_ottoauszahlung drop
    constraint `fk_blg_taxregistration_ottoauszahlung_id` // 

alter table blg_taxregistration_ottoauszahlung add
    constraint `fk_blg_taxregistration_ottoauszahlung_id`
     foreign key (`id`) references `blg_hdr_ottoauszahlung` (`id`) on delete cascade on update cascade//

alter table blg_buyer_ottoauszahlung drop
    constraint `fk_blg_buyer_ottoauszahlung_id` // 

alter table blg_buyer_ottoauszahlung add
    constraint `fk_blg_buyer_ottoauszahlung_id`
     foreign key (`id`) references `blg_hdr_ottoauszahlung` (`id`) on delete cascade on update cascade//
alter table blg_seller_ottoauszahlung drop
    constraint `fk_blg_seller_ottoauszahlung_id` // 

alter table blg_seller_ottoauszahlung add
    constraint `fk_blg_seller_ottoauszahlung_id`
     foreign key (`id`) references `blg_hdr_ottoauszahlung` (`id`) on delete cascade on update cascade//


