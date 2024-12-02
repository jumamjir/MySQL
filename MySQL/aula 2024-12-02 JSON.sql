SELECT * FROM classicos.tabela_json;

insert into classicos.tabela_json (doc_json) values ('{"aluno":{"nome":"Jose","serie":8,"classe":"B","notas":[{"matematica":8,"portugues":7.5,"ciencias":9},{"matematica":7,"portugues":8,"ciencias":6}]}}');

select id,doc_json->"$.name" col_nome from classicos.tabela_json where doc_json->"$.name" is not null;

insert into tabela_json (doc_json) values (
    '{
        "id": 455,
        "name": "YIRVaWMhDM",
        "email": "pnHVnQHGMK@example.com",
        "age": 19,
        "address": {
            "street": "jYZdcVkioi",
            "city": "TonQbTWLWL",
            "zipcode": "94144"
        }
    }');
insert into tabela_json (doc_json) values (
    '{
        "id": 616,
        "name": "olLxKgINwW",
        "email": "FuyaFGGSrS@example.com",
        "age": 45,
        "address": {
            "street": "FnBMzVpNWm",
            "city": "BBODYQlbOV",
            "zipcode": "87135"
        }
    }');

insert into tabela_json (doc_json) values (
    '{
        "id": 257,
        "name": "VGFROFlMiA",
        "email": "wmdfIcRulw@example.com",
        "age": 20,
        "address": {
            "street": "gDFIBtzbje",
            "city": "hDBUnEFqWX",
            "zipcode": "05536"
        }
    }');
insert into tabela_json (doc_json) values (
    '{
        "id": 964,
        "name": "bZNsdHkLlT",
        "email": "ZIUXrChnju@example.com",
        "age": 70,
        "address": {
            "street": "HydMVoRpkH",
            "city": "KRXWdoYMnz",
            "zipcode": "52012"
        }
    }');

insert into tabela_json (doc_json) values (
    '{
        "id": 695,
        "name": "INSdDCivSB",
        "email": "xzTlICLCKA@example.com",
        "age": 59,
        "address": {
            "street": "erOIiqppwn",
            "city": "EMEoSUxfPZ",
            "zipcode": "08853"
        }
    }');

insert into tabela_json (doc_json) values (
    '{
        "id": 36,
        "name": "fVdrzXWNvJ",
        "email": "ZrrRwYEKJY@example.com",
        "age": 41,
        "address": {
            "street": "SQzGQDWSVG",
            "city": "bDFLbopOKz",
            "zipcode": "76826"
        }
    }');
