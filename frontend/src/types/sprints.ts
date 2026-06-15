export interface EntregaSprint {
    titulo_entrega: string | null;
    link_repositorio: string | null;
    data_submissao: Date | null;
}

export interface SprintDetalhada {
    codigo_equipe: number;
    nome_projeto: string
    numero_sprint: number;
    prazo_sprint: Date;
    entregas: EntregaSprint[];
}