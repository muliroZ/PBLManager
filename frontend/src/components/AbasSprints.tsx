import { useState, useEffect } from "react";
import { type SprintDetalhada } from "../types/sprints";

interface AbasSprintProps {
    codigoEquipe: number;
}

export function AbasSprints({ codigoEquipe }: AbasSprintProps) {
    const [sprints, setSprints] = useState<SprintDetalhada[]>([]);
    const [sprintAtiva, setSprintAtiva] = useState<number | null>(null);
    const [loading, setLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
      setLoading(true);
      fetch(`http://localhost:5000/api/equipes/${codigoEquipe}/sprints`)
        .then((res) => {
            if (!res.ok) throw new Error("Erro ao procurar as sprints.");
            return res.json();
        })
        .then((data: SprintDetalhada[]) => {
            setSprints(data);
            if (data.length > 0) {
                setSprintAtiva(data[0].numero_sprint);
            }
            setLoading(false);
        })
        .catch((err) => {
            setError(err.message);
            setLoading(false);
        });
    }, [codigoEquipe])

    if (loading) return <p>Carregando cronograma de sprints...</p>;
    if (error) return <p style={{ color: 'red' }}>{error}</p>;
    if (sprints.length === 0) return <p>Nenhuma sprint encontrada para esta equipe.</p>;
    
    const dadosDaSprintSelecionada = sprints.find(s => s.numero_sprint === sprintAtiva);

    return (
        <div style={{ marginTop: '2rem', textAlign: 'left' }}>
            <h3>Acompanhamento de Sprints</h3>

            <div style={{ display: 'flex', gap: '0.5rem', borderBottom: '2px solid #ccc', paddingBottom: '0.5rem' }}>
                {sprints.map((sprint) => {
                const estaAtiva = sprint.numero_sprint === sprintAtiva;
                return (
                    <button
                    key={sprint.numero_sprint}
                    onClick={() => setSprintAtiva(sprint.numero_sprint)}
                    style={{
                        padding: '0.5rem 1rem',
                        cursor: 'pointer',
                        backgroundColor: estaAtiva ? '#0070f3' : '#f0f0f0',
                        color: estaAtiva ? 'white' : 'black',
                        border: '1px solid #ccc',
                        borderRadius: '4px 4px 0 0',
                        fontWeight: estaAtiva ? 'bold' : 'normal'
                    }}
                    >
                    Sprint {sprint.numero_sprint}
                    </button>
                );
                })}
            </div>

            {dadosDaSprintSelecionada && (
                <div style={{ padding: '1rem', border: '1px solid #ccc', borderTop: 'none', backgroundColor: '#fafafa', color: '#000' }}>
                <p><strong>Prazo de Entrega:</strong> {new Date(dadosDaSprintSelecionada.prazo_sprint).toLocaleDateString()}</p>
                
                <h4>Entregas efetuadas nesta Sprint:</h4>
                {dadosDaSprintSelecionada.entregas.length === 0 || !dadosDaSprintSelecionada.entregas[0].titulo_entrega ? (
                    <p style={{ color: '#666', fontStyle: 'italic' }}>Nenhuma entrega submetida até ao momento.</p>
                ) : (
                    <table style={{ width: '100%', borderCollapse: 'collapse', marginTop: '1rem' }}>
                    <thead>
                        <tr style={{ backgroundColor: '#ddd' }}>
                        <th style={{ padding: '0.5rem', border: '1px solid #ccc' }}>Título da Entrega</th>
                        <th style={{ padding: '0.5rem', border: '1px solid #ccc' }}>Data de Submissão</th>
                        <th style={{ padding: '0.5rem', border: '1px solid #ccc' }}>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        {dadosDaSprintSelecionada.entregas.map((entrega, idx) => (
                        <tr key={idx}>
                            <td style={{ padding: '0.5rem', border: '1px solid #ccc' }}>{entrega.titulo_entrega}</td>
                            <td style={{ padding: '0.5rem', border: '1px solid #ccc' }}>
                            {entrega.data_submissao ? new Date(entrega.data_submissao).toLocaleDateString() : '-'}
                            </td>
                            <td style={{ padding: '0.5rem', border: '1px solid #ccc' }}>
                            {entrega.link_repositorio && (
                                <a href={entrega.link_repositorio} target="_blank" rel="noreferrer">
                                Acessar o Repositório
                                </a>
                            )}
                            </td>
                        </tr>
                        ))}
                    </tbody>
                    </table>
                )}
                </div>
            )}
        </div>
    );
}