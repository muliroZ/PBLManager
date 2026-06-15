export interface Membro {
    nome: string;
    papel: string;
}

export interface Equipe {
    codigo_equipe: number;
    codigo_projeto: number | null;
    nome_do_projeto: string | null;
    membros: Membro[];
}

export interface GithubResponse {
    link_github: string;
}