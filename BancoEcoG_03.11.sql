--
-- PostgreSQL database dump
--

\restrict gUTFQ1BIAQCVmhFe25Dm6TJ2TQCED4bZO4UyY7saOaojFpxI9mNgG0XjsDi6mv8

-- Dumped from database version 15.14
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-03 19:07:17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 231 (class 1259 OID 16678)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id_cliente integer NOT NULL,
    nome_cliente character varying(255) NOT NULL,
    documento character varying(32),
    telefone character varying(50),
    email character varying(255),
    cidade character varying(100),
    uf character(2),
    endereco character varying(255),
    observacoes text
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16677)
-- Name: clientes_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.clientes ALTER COLUMN id_cliente ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.clientes_id_cliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 16583)
-- Name: custos_adicionais_clicheria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.custos_adicionais_clicheria (
    id_custo_clicheria integer NOT NULL,
    id_medida integer NOT NULL,
    id_tipo_impressao integer NOT NULL,
    descricao_custo character varying(100) NOT NULL,
    valor numeric(10,2) NOT NULL,
    observacao character varying(255)
);


ALTER TABLE public.custos_adicionais_clicheria OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16586)
-- Name: custos_adicionais_clicheria_id_custo_clicheria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.custos_adicionais_clicheria ALTER COLUMN id_custo_clicheria ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.custos_adicionais_clicheria_id_custo_clicheria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16587)
-- Name: faixas_quantidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faixas_quantidade (
    id_faixa integer NOT NULL,
    descricao_faixa character varying(100) NOT NULL,
    nome_alternativo character varying(100)
);


ALTER TABLE public.faixas_quantidade OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16590)
-- Name: faixas_quantidade_id_faixa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.faixas_quantidade ALTER COLUMN id_faixa ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.faixas_quantidade_id_faixa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 237 (class 1259 OID 16721)
-- Name: itens_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itens_pedido (
    id_item integer NOT NULL,
    id_pedido integer NOT NULL,
    id_produto_base integer NOT NULL,
    id_medida integer NOT NULL,
    id_tipo_impressao integer NOT NULL,
    id_faixa integer,
    quantidade integer NOT NULL,
    valor_milheiro_aplicado numeric(10,2) NOT NULL,
    valor_unitario_aplicado numeric(10,2) NOT NULL,
    valor_cliche_aplicado numeric(10,2) DEFAULT 0.00 NOT NULL,
    acrescimo_fixo_reais numeric(10,2) DEFAULT 0.00 NOT NULL,
    observacao_item character varying(255),
    id_preco_referencia integer,
    CONSTRAINT ck_itens_valores_pos CHECK (((valor_milheiro_aplicado >= (0)::numeric) AND (valor_unitario_aplicado >= (0)::numeric) AND (valor_cliche_aplicado >= (0)::numeric) AND (acrescimo_fixo_reais >= (0)::numeric))),
    CONSTRAINT itens_pedido_quantidade_check CHECK ((quantidade > 0))
);


ALTER TABLE public.itens_pedido OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16720)
-- Name: itens_pedido_id_item_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.itens_pedido ALTER COLUMN id_item ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.itens_pedido_id_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16591)
-- Name: medidas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medidas (
    id_medida integer NOT NULL,
    descricao_medida character varying(100) NOT NULL
);


ALTER TABLE public.medidas OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16594)
-- Name: medidas_id_medida_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.medidas ALTER COLUMN id_medida ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.medidas_id_medida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16595)
-- Name: precos_milheiro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.precos_milheiro (
    id_preco integer NOT NULL,
    id_produto_base integer NOT NULL,
    id_medida integer NOT NULL,
    id_tipo_impressao integer NOT NULL,
    id_faixa integer NOT NULL,
    valor_milheiro numeric(10,2) NOT NULL
);


ALTER TABLE public.precos_milheiro OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16598)
-- Name: produtos_base; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produtos_base (
    id_produto_base integer NOT NULL,
    nome_produto character varying(255) NOT NULL,
    material character varying(100),
    gramatura integer,
    versao_tabela character varying(50) NOT NULL,
    CONSTRAINT ck_gramatura_pos CHECK (((gramatura IS NULL) OR (gramatura > 0)))
);


ALTER TABLE public.produtos_base OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16602)
-- Name: tipos_impressao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipos_impressao (
    id_tipo_impressao integer NOT NULL,
    nome_impressao character varying(255) NOT NULL,
    categoria character varying(100),
    num_cores integer,
    CONSTRAINT ck_num_cores CHECK (((num_cores IS NULL) OR (num_cores >= 0)))
);


ALTER TABLE public.tipos_impressao OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16606)
-- Name: pedido18; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.pedido18 AS
 SELECT pb.nome_produto,
    pb.material,
    pb.gramatura,
    m.descricao_medida,
    ti.nome_impressao,
    f.descricao_faixa,
    pm.valor_milheiro,
    round((pm.valor_milheiro / (1000)::numeric), 2) AS valor_unitario,
    COALESCE(c.valor, (0)::numeric) AS valor_cliche,
    1000 AS quantidade,
    round(((pm.valor_milheiro / (1000)::numeric) * (1000)::numeric), 2) AS subtotal_sem_cliche,
    round((((pm.valor_milheiro / (1000)::numeric) * (1000)::numeric) + COALESCE(c.valor, (0)::numeric)), 2) AS total_com_cliche
   FROM (((((public.precos_milheiro pm
     JOIN public.produtos_base pb ON ((pb.id_produto_base = pm.id_produto_base)))
     JOIN public.medidas m ON ((m.id_medida = pm.id_medida)))
     JOIN public.tipos_impressao ti ON ((ti.id_tipo_impressao = pm.id_tipo_impressao)))
     JOIN public.faixas_quantidade f ON ((f.id_faixa = pm.id_faixa)))
     LEFT JOIN public.custos_adicionais_clicheria c ON (((c.id_medida = pm.id_medida) AND (c.id_tipo_impressao = pm.id_tipo_impressao) AND ((c.descricao_custo)::text = 'LOGO'::text))));


ALTER VIEW public.pedido18 OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16695)
-- Name: pedidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedidos (
    id_pedido integer NOT NULL,
    id_cliente integer NOT NULL,
    id_vendedor integer,
    data_pedido timestamp with time zone DEFAULT now() NOT NULL,
    data_entrega date,
    status character varying(30) DEFAULT 'Em análise'::character varying NOT NULL,
    condicao_pagto character varying(100),
    desconto_reais numeric(10,2) DEFAULT 0.00 NOT NULL,
    frete_reais numeric(10,2) DEFAULT 0.00 NOT NULL,
    observacoes text,
    CONSTRAINT ck_pedidos_status CHECK (((status)::text = ANY ((ARRAY['Em análise'::character varying, 'Aprovado'::character varying, 'Produção'::character varying, 'Faturado'::character varying, 'Cancelado'::character varying])::text[]))),
    CONSTRAINT ck_pedidos_valores_pos CHECK (((desconto_reais >= (0)::numeric) AND (frete_reais >= (0)::numeric)))
);


ALTER TABLE public.pedidos OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16694)
-- Name: pedidos_id_pedido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pedidos ALTER COLUMN id_pedido ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pedidos_id_pedido_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16611)
-- Name: pedidoteste18; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.pedidoteste18 AS
 WITH base AS (
         SELECT pb.nome_produto,
            pb.material,
            pb.gramatura,
            m.descricao_medida,
            ti.nome_impressao,
            f.descricao_faixa,
            pm.valor_milheiro,
            COALESCE(c.valor, (0)::numeric) AS valor_cliche
           FROM (((((public.precos_milheiro pm
             JOIN public.produtos_base pb ON ((pb.id_produto_base = pm.id_produto_base)))
             JOIN public.medidas m ON ((m.id_medida = pm.id_medida)))
             JOIN public.tipos_impressao ti ON ((ti.id_tipo_impressao = pm.id_tipo_impressao)))
             JOIN public.faixas_quantidade f ON ((f.id_faixa = pm.id_faixa)))
             LEFT JOIN public.custos_adicionais_clicheria c ON (((c.id_medida = pm.id_medida) AND (c.id_tipo_impressao = pm.id_tipo_impressao) AND ((c.descricao_custo)::text = 'LOGO'::text))))
          WHERE (((pb.material)::text = 'Kraft pardo'::text) AND (pb.gramatura = 80) AND ((m.descricao_medida)::text = '18x28x10,5'::text) AND ((ti.nome_impressao)::text = '1 Cor - Logo'::text))
        ), escolha AS (
         SELECT DISTINCT ON (base.nome_produto, base.material, base.gramatura, base.descricao_medida, base.nome_impressao) base.nome_produto,
            base.material,
            base.gramatura,
            base.descricao_medida,
            base.nome_impressao,
            base.descricao_faixa,
            base.valor_milheiro,
            base.valor_cliche
           FROM base
          ORDER BY base.nome_produto, base.material, base.gramatura, base.descricao_medida, base.nome_impressao,
                CASE
                    WHEN ((base.descricao_faixa)::text = '1.000 a 1.500'::text) THEN 1
                    WHEN ((base.descricao_faixa)::text = '2.000 a 3.000'::text) THEN 2
                    WHEN ((base.descricao_faixa)::text = 'Combo 3.000'::text) THEN 3
                    ELSE 9
                END
        )
 SELECT escolha.nome_produto,
    escolha.material,
    escolha.gramatura,
    escolha.descricao_medida,
    escolha.nome_impressao,
    escolha.descricao_faixa AS faixa_usada,
    escolha.valor_milheiro,
    round((escolha.valor_milheiro / (1000)::numeric), 2) AS valor_unitario,
    escolha.valor_cliche,
    1000 AS quantidade,
    round(((escolha.valor_milheiro / (1000)::numeric) * (1000)::numeric), 2) AS subtotal_sem_cliche,
    round((((escolha.valor_milheiro / (1000)::numeric) * (1000)::numeric) + escolha.valor_cliche), 2) AS total_com_cliche
   FROM escolha;


ALTER VIEW public.pedidoteste18 OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16616)
-- Name: precos_milheiro_id_preco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.precos_milheiro ALTER COLUMN id_preco ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.precos_milheiro_id_preco_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16617)
-- Name: produtos_base_id_produto_base_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.produtos_base ALTER COLUMN id_produto_base ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.produtos_base_id_produto_base_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 16618)
-- Name: tipos_impressao_id_tipo_impressao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tipos_impressao ALTER COLUMN id_tipo_impressao ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tipos_impressao_id_tipo_impressao_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 16686)
-- Name: vendedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendedores (
    id_vendedor integer NOT NULL,
    nome_vendedor character varying(255) NOT NULL,
    email character varying(255),
    telefone character varying(50),
    nivel character varying(50),
    ativo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.vendedores OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16685)
-- Name: vendedores_id_vendedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.vendedores ALTER COLUMN id_vendedor ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.vendedores_id_vendedor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16619)
-- Name: vw_pedido_34x38; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_pedido_34x38 AS
 WITH base AS (
         SELECT pb.nome_produto,
            pb.material,
            pb.gramatura,
            m.descricao_medida,
            ti.nome_impressao,
            f.descricao_faixa,
            pm.valor_milheiro,
            COALESCE(c.valor, (0)::numeric) AS valor_cliche
           FROM (((((public.precos_milheiro pm
             JOIN public.produtos_base pb ON ((pb.id_produto_base = pm.id_produto_base)))
             JOIN public.medidas m ON ((m.id_medida = pm.id_medida)))
             JOIN public.tipos_impressao ti ON ((ti.id_tipo_impressao = pm.id_tipo_impressao)))
             JOIN public.faixas_quantidade f ON ((f.id_faixa = pm.id_faixa)))
             LEFT JOIN public.custos_adicionais_clicheria c ON (((c.id_medida = pm.id_medida) AND (c.id_tipo_impressao = pm.id_tipo_impressao) AND (upper(TRIM(BOTH FROM c.descricao_custo)) = 'CHAPADO'::text))))
          WHERE ((upper(TRIM(BOTH FROM pb.material)) = 'KRAFT PARDO'::text) AND (upper(TRIM(BOTH FROM m.descricao_medida)) = '34X38X14'::text) AND (upper(TRIM(BOTH FROM ti.nome_impressao)) = '1 COR - CHAPADO'::text) AND (pb.gramatura = 100))
        ), escolha AS (
         SELECT DISTINCT ON (base.material, base.gramatura, base.descricao_medida, base.nome_impressao) base.nome_produto,
            base.material,
            base.gramatura,
            base.descricao_medida,
            base.nome_impressao,
            base.descricao_faixa,
            base.valor_milheiro,
            base.valor_cliche
           FROM base
          ORDER BY base.material, base.gramatura, base.descricao_medida, base.nome_impressao,
                CASE
                    WHEN ((base.descricao_faixa)::text = '1.000 a 1.500'::text) THEN 1
                    WHEN ((base.descricao_faixa)::text = '2.000 a 3.000'::text) THEN 2
                    WHEN ((base.descricao_faixa)::text = 'Combo 3.000'::text) THEN 3
                    ELSE 9
                END
        )
 SELECT escolha.nome_produto,
    escolha.material,
    escolha.gramatura,
    escolha.descricao_medida,
    escolha.nome_impressao,
    escolha.descricao_faixa AS faixa_usada,
    escolha.valor_milheiro,
    round((escolha.valor_milheiro / (1000)::numeric), 2) AS valor_unitario,
    escolha.valor_cliche,
    1500 AS quantidade,
    round(((escolha.valor_milheiro / 1000.0) * (1500)::numeric), 2) AS subtotal_sem_cliche,
    round((((escolha.valor_milheiro / 1000.0) * (1500)::numeric) + escolha.valor_cliche), 2) AS total_com_cliche
   FROM escolha;


ALTER VIEW public.vw_pedido_34x38 OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16624)
-- Name: vw_pedido_completo; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_pedido_completo AS
 SELECT pb.nome_produto,
    pb.material,
    pb.gramatura,
    m.descricao_medida,
    ti.nome_impressao,
    f.descricao_faixa,
    pm.valor_milheiro,
    round((pm.valor_milheiro / (1000)::numeric), 2) AS valor_unitario,
    COALESCE(c.valor, (0)::numeric) AS valor_cliche,
    (pm.valor_milheiro + COALESCE(c.valor, (0)::numeric)) AS total_pedido_milheiro,
    round(((pm.valor_milheiro + COALESCE(c.valor, (0)::numeric)) / (1000)::numeric), 2) AS total_unitario_com_cliche
   FROM (((((public.precos_milheiro pm
     JOIN public.produtos_base pb ON ((pb.id_produto_base = pm.id_produto_base)))
     JOIN public.medidas m ON ((m.id_medida = pm.id_medida)))
     JOIN public.tipos_impressao ti ON ((ti.id_tipo_impressao = pm.id_tipo_impressao)))
     JOIN public.faixas_quantidade f ON ((f.id_faixa = pm.id_faixa)))
     LEFT JOIN public.custos_adicionais_clicheria c ON (((c.id_medida = pm.id_medida) AND (c.id_tipo_impressao = pm.id_tipo_impressao) AND ((c.descricao_custo)::text = 'LOGO'::text))));


ALTER VIEW public.vw_pedido_completo OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16762)
-- Name: vw_resumo_pedido; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_resumo_pedido AS
 SELECT p.id_pedido,
    p.data_pedido,
    p.status,
    c.nome_cliente,
    p.condicao_pagto,
    (COALESCE(sum(((((i.quantidade)::numeric * i.valor_unitario_aplicado) + i.valor_cliche_aplicado) + i.acrescimo_fixo_reais)), (0)::numeric))::numeric(12,2) AS total_itens,
    p.frete_reais,
    p.desconto_reais,
    round(((COALESCE(sum(((((i.quantidade)::numeric * i.valor_unitario_aplicado) + i.valor_cliche_aplicado) + i.acrescimo_fixo_reais)), (0)::numeric) + p.frete_reais) - p.desconto_reais), 2) AS total_pedido
   FROM ((public.pedidos p
     LEFT JOIN public.clientes c ON ((c.id_cliente = p.id_cliente)))
     LEFT JOIN public.itens_pedido i ON ((i.id_pedido = p.id_pedido)))
  GROUP BY p.id_pedido, p.data_pedido, p.status, c.nome_cliente, p.condicao_pagto, p.frete_reais, p.desconto_reais;


ALTER VIEW public.vw_resumo_pedido OWNER TO postgres;

--
-- TOC entry 3455 (class 0 OID 16678)
-- Dependencies: 231
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id_cliente, nome_cliente, documento, telefone, email, cidade, uf, endereco, observacoes) FROM stdin;
1	Mundo dos Cosméticos	12.345.678/0001-90	\N	\N	Itapetininga	SP	\N	\N
\.


--
-- TOC entry 3442 (class 0 OID 16583)
-- Dependencies: 214
-- Data for Name: custos_adicionais_clicheria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custos_adicionais_clicheria (id_custo_clicheria, id_medida, id_tipo_impressao, descricao_custo, valor, observacao) FROM stdin;
1	3	1	LOGO	250.00	Pode variar conforme arte
2	1	1	LOGO	180.00	Clichê compartilhado possível
\.


--
-- TOC entry 3444 (class 0 OID 16587)
-- Dependencies: 216
-- Data for Name: faixas_quantidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faixas_quantidade (id_faixa, descricao_faixa, nome_alternativo) FROM stdin;
1	1.000 a 1.500	\N
2	2.000 a 3.000	\N
3	Combo 3.000	Combo 3.000
4	5.000 a 6.000	\N
5	Combo\\n10.000	Combo 10.000
\.


--
-- TOC entry 3461 (class 0 OID 16721)
-- Dependencies: 237
-- Data for Name: itens_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itens_pedido (id_item, id_pedido, id_produto_base, id_medida, id_tipo_impressao, id_faixa, quantidade, valor_milheiro_aplicado, valor_unitario_aplicado, valor_cliche_aplicado, acrescimo_fixo_reais, observacao_item, id_preco_referencia) FROM stdin;
1	1	1	1	1	3	1000	1140.00	1.14	180.00	0.00	LOGO 18x28	3
\.


--
-- TOC entry 3446 (class 0 OID 16591)
-- Dependencies: 218
-- Data for Name: medidas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medidas (id_medida, descricao_medida) FROM stdin;
1	18x28x10,5
2	25x26x12
3	25x38x12
4	34x38x14
5	28x36x17
6	34x36x14
\.


--
-- TOC entry 3459 (class 0 OID 16695)
-- Dependencies: 235
-- Data for Name: pedidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedidos (id_pedido, id_cliente, id_vendedor, data_pedido, data_entrega, status, condicao_pagto, desconto_reais, frete_reais, observacoes) FROM stdin;
1	1	1	2025-11-03 17:42:52.827284-03	\N	Em análise	6x	0.00	0.00	Pedido de teste
\.


--
-- TOC entry 3448 (class 0 OID 16595)
-- Dependencies: 220
-- Data for Name: precos_milheiro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.precos_milheiro (id_preco, id_produto_base, id_medida, id_tipo_impressao, id_faixa, valor_milheiro) FROM stdin;
1	1	2	1	3	1290.00
2	1	3	1	3	1490.00
3	1	1	1	3	1140.00
\.


--
-- TOC entry 3449 (class 0 OID 16598)
-- Dependencies: 221
-- Data for Name: produtos_base; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produtos_base (id_produto_base, nome_produto, material, gramatura, versao_tabela) FROM stdin;
1	Saco SOS	Kraft pardo	80	2025-10
2	Saco SOS	Kraft pardo	100	2025-10
3	Sacola	Papel branco	100	2025-10
\.


--
-- TOC entry 3450 (class 0 OID 16602)
-- Dependencies: 222
-- Data for Name: tipos_impressao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipos_impressao (id_tipo_impressao, nome_impressao, categoria, num_cores) FROM stdin;
1	1 Cor - Logo	1 Cor	1
2	1 Cor -\\nChapado	Chapado	1
3	2 Cores - Frente	2 Cores	2
\.


--
-- TOC entry 3457 (class 0 OID 16686)
-- Dependencies: 233
-- Data for Name: vendedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendedores (id_vendedor, nome_vendedor, email, telefone, nivel, ativo) FROM stdin;
1	Cayos	eco@ecogioti.com.br	\N	\N	t
\.


--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 230
-- Name: clientes_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_cliente_seq', 1, true);


--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 215
-- Name: custos_adicionais_clicheria_id_custo_clicheria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.custos_adicionais_clicheria_id_custo_clicheria_seq', 2, true);


--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 217
-- Name: faixas_quantidade_id_faixa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faixas_quantidade_id_faixa_seq', 5, true);


--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 236
-- Name: itens_pedido_id_item_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.itens_pedido_id_item_seq', 1, true);


--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 219
-- Name: medidas_id_medida_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medidas_id_medida_seq', 6, true);


--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 234
-- Name: pedidos_id_pedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedidos_id_pedido_seq', 1, true);


--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 225
-- Name: precos_milheiro_id_preco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.precos_milheiro_id_preco_seq', 3, true);


--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 226
-- Name: produtos_base_id_produto_base_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produtos_base_id_produto_base_seq', 3, true);


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 227
-- Name: tipos_impressao_id_tipo_impressao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipos_impressao_id_tipo_impressao_seq', 3, true);


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 232
-- Name: vendedores_id_vendedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendedores_id_vendedor_seq', 1, true);


--
-- TOC entry 3270 (class 2606 OID 16684)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 3252 (class 2606 OID 16630)
-- Name: custos_adicionais_clicheria custos_adicionais_clicheria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custos_adicionais_clicheria
    ADD CONSTRAINT custos_adicionais_clicheria_pkey PRIMARY KEY (id_custo_clicheria);


--
-- TOC entry 3256 (class 2606 OID 16632)
-- Name: faixas_quantidade faixas_quantidade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faixas_quantidade
    ADD CONSTRAINT faixas_quantidade_pkey PRIMARY KEY (id_faixa);


--
-- TOC entry 3278 (class 2606 OID 16729)
-- Name: itens_pedido itens_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT itens_pedido_pkey PRIMARY KEY (id_item);


--
-- TOC entry 3258 (class 2606 OID 16634)
-- Name: medidas medidas_descricao_medida_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medidas
    ADD CONSTRAINT medidas_descricao_medida_key UNIQUE (descricao_medida);


--
-- TOC entry 3260 (class 2606 OID 16636)
-- Name: medidas medidas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medidas
    ADD CONSTRAINT medidas_pkey PRIMARY KEY (id_medida);


--
-- TOC entry 3276 (class 2606 OID 16707)
-- Name: pedidos pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id_pedido);


--
-- TOC entry 3262 (class 2606 OID 16638)
-- Name: precos_milheiro precos_milheiro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precos_milheiro
    ADD CONSTRAINT precos_milheiro_pkey PRIMARY KEY (id_preco);


--
-- TOC entry 3266 (class 2606 OID 16640)
-- Name: produtos_base produtos_base_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos_base
    ADD CONSTRAINT produtos_base_pkey PRIMARY KEY (id_produto_base);


--
-- TOC entry 3268 (class 2606 OID 16642)
-- Name: tipos_impressao tipos_impressao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipos_impressao
    ADD CONSTRAINT tipos_impressao_pkey PRIMARY KEY (id_tipo_impressao);


--
-- TOC entry 3254 (class 2606 OID 16644)
-- Name: custos_adicionais_clicheria uq_cliche_combo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custos_adicionais_clicheria
    ADD CONSTRAINT uq_cliche_combo UNIQUE (id_medida, id_tipo_impressao, descricao_custo);


--
-- TOC entry 3264 (class 2606 OID 16646)
-- Name: precos_milheiro uq_preco_combo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precos_milheiro
    ADD CONSTRAINT uq_preco_combo UNIQUE (id_produto_base, id_medida, id_tipo_impressao, id_faixa);


--
-- TOC entry 3272 (class 2606 OID 16693)
-- Name: vendedores vendedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedores
    ADD CONSTRAINT vendedores_pkey PRIMARY KEY (id_vendedor);


--
-- TOC entry 3279 (class 1259 OID 16761)
-- Name: ix_itens_conf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_itens_conf ON public.itens_pedido USING btree (id_produto_base, id_medida, id_tipo_impressao);


--
-- TOC entry 3280 (class 1259 OID 16760)
-- Name: ix_itens_pedido_pedido; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_itens_pedido_pedido ON public.itens_pedido USING btree (id_pedido);


--
-- TOC entry 3273 (class 1259 OID 16718)
-- Name: ix_pedidos_cliente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_pedidos_cliente ON public.pedidos USING btree (id_cliente);


--
-- TOC entry 3274 (class 1259 OID 16719)
-- Name: ix_pedidos_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_pedidos_status ON public.pedidos USING btree (status);


--
-- TOC entry 3281 (class 2606 OID 16647)
-- Name: custos_adicionais_clicheria custos_adicionais_clicheria_id_medida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custos_adicionais_clicheria
    ADD CONSTRAINT custos_adicionais_clicheria_id_medida_fkey FOREIGN KEY (id_medida) REFERENCES public.medidas(id_medida);


--
-- TOC entry 3282 (class 2606 OID 16652)
-- Name: custos_adicionais_clicheria custos_adicionais_clicheria_id_tipo_impressao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.custos_adicionais_clicheria
    ADD CONSTRAINT custos_adicionais_clicheria_id_tipo_impressao_fkey FOREIGN KEY (id_tipo_impressao) REFERENCES public.tipos_impressao(id_tipo_impressao);


--
-- TOC entry 3289 (class 2606 OID 16750)
-- Name: itens_pedido fk_itens_faixa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT fk_itens_faixa FOREIGN KEY (id_faixa) REFERENCES public.faixas_quantidade(id_faixa);


--
-- TOC entry 3290 (class 2606 OID 16740)
-- Name: itens_pedido fk_itens_medida; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT fk_itens_medida FOREIGN KEY (id_medida) REFERENCES public.medidas(id_medida);


--
-- TOC entry 3291 (class 2606 OID 16730)
-- Name: itens_pedido fk_itens_pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT fk_itens_pedido FOREIGN KEY (id_pedido) REFERENCES public.pedidos(id_pedido) ON DELETE CASCADE;


--
-- TOC entry 3292 (class 2606 OID 16755)
-- Name: itens_pedido fk_itens_preco_ref; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT fk_itens_preco_ref FOREIGN KEY (id_preco_referencia) REFERENCES public.precos_milheiro(id_preco);


--
-- TOC entry 3293 (class 2606 OID 16735)
-- Name: itens_pedido fk_itens_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT fk_itens_produto FOREIGN KEY (id_produto_base) REFERENCES public.produtos_base(id_produto_base);


--
-- TOC entry 3294 (class 2606 OID 16745)
-- Name: itens_pedido fk_itens_tipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT fk_itens_tipo FOREIGN KEY (id_tipo_impressao) REFERENCES public.tipos_impressao(id_tipo_impressao);


--
-- TOC entry 3287 (class 2606 OID 16708)
-- Name: pedidos fk_pedidos_clientes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT fk_pedidos_clientes FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 3288 (class 2606 OID 16713)
-- Name: pedidos fk_pedidos_vendedores; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT fk_pedidos_vendedores FOREIGN KEY (id_vendedor) REFERENCES public.vendedores(id_vendedor);


--
-- TOC entry 3283 (class 2606 OID 16657)
-- Name: precos_milheiro precos_milheiro_id_faixa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precos_milheiro
    ADD CONSTRAINT precos_milheiro_id_faixa_fkey FOREIGN KEY (id_faixa) REFERENCES public.faixas_quantidade(id_faixa);


--
-- TOC entry 3284 (class 2606 OID 16662)
-- Name: precos_milheiro precos_milheiro_id_medida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precos_milheiro
    ADD CONSTRAINT precos_milheiro_id_medida_fkey FOREIGN KEY (id_medida) REFERENCES public.medidas(id_medida);


--
-- TOC entry 3285 (class 2606 OID 16667)
-- Name: precos_milheiro precos_milheiro_id_produto_base_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precos_milheiro
    ADD CONSTRAINT precos_milheiro_id_produto_base_fkey FOREIGN KEY (id_produto_base) REFERENCES public.produtos_base(id_produto_base);


--
-- TOC entry 3286 (class 2606 OID 16672)
-- Name: precos_milheiro precos_milheiro_id_tipo_impressao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.precos_milheiro
    ADD CONSTRAINT precos_milheiro_id_tipo_impressao_fkey FOREIGN KEY (id_tipo_impressao) REFERENCES public.tipos_impressao(id_tipo_impressao);

ALTER DATABASE nome_do_banco SET search_path TO public;

-- Completed on 2025-11-03 19:07:17

--
-- PostgreSQL database dump complete
--

\unrestrict gUTFQ1BIAQCVmhFe25Dm6TJ2TQCED4bZO4UyY7saOaojFpxI9mNgG0XjsDi6mv8

