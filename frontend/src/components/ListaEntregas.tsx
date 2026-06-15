import { type EntregaSprint } from "../types/sprints";

interface ListaEntregasProps {
    entregas: EntregaSprint[];
}

export function ListaEntregas({ entregas }: ListaEntregasProps) {
    if (entregas.length === 0 || !entregas[0].titulo_entrega) {
        return (
            <p style={{ color: '#777', fontStyle: 'italic', padding: '1rem 0' }}>
                Nenhuma entrega ou versão de repositório submetida nesta sprint até o momento.
            </p>
        );
    }

    return (
        <div style={{ marginTop: '1rem' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                <thead>
                    <tr style={{ backgroundColor: '#f4f4f5', borderBottom: '2px solid #e4e4e7' }}>
                        <th style={{ padding: '0.75rem' }}>Título da Entrega</th>
                        <th style={{ padding: '0.75rem' }}>Data de Submissão</th>
                        <th style={{ padding: '0.75rem' }}>Repositório</th>
                    </tr>
                </thead>
                <tbody>
                    {entregas.map((entrega, index) => (
                        <tr key={index} style={{ borderBottom: '1px solid #e4e4e7' }}>
                            <td style={{ padding: '0.75rem' }}>
                                {entrega.titulo_entrega}
                            </td>
                            <td style={{ padding: '0.75rem' }}>
                                {entrega.data_submissao
                                    ? new Date(entrega.data_submissao).toLocaleDateString('pt-BR')
                                    : 'Data pendente'}
                            </td>
                            <td style={{ padding: '0.75rem' }}>
                                {entrega.link_repositorio ? (
                                    <a 
                                      href={entrega.link_repositorio}
                                      target="_blank"
                                      rel="noopener noreferrer"
                                      style={{ color: '#0070f3', textDecoration: 'none', fontWeight: '500',  }}
                                    >
                                        Acessar GitHub
                                    </a>
                                ) : (
                                    <span style={{ color: '#a1a1aa' }}>Link não enviado</span>
                                )}
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}