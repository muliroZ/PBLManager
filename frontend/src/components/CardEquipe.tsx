import { type Equipe, type GithubResponse } from "../types/equipes";

interface CardEquipeProps {
    equipe: Equipe;
    onVerSprints: () => void;
}

export function CardEquipe({ equipe, onVerSprints }: CardEquipeProps) {
    function handleVerGitHub() {
        try {
            fetch(
                `http://localhost:5000/api/equipes/${equipe.codigo_equipe}/projeto/${equipe.codigo_projeto}/projeto`
            )
            .then((res) => {
                if (!res.ok) throw new Error("Erro ao buscar o link do repositório.");
                return res.json();
            })
            .then((data: GithubResponse) => {
                window.open(data.link_github, '_blank')
            })
        } catch (err) {
            console.error("Erro: ", err)
        }
    }

    return (
        <div style={{ border: '1px solid #ccc', borderRadius: '15px', padding: '1rem' }}>
            <h2 style={{ border: '1px solid #ccc', padding: '1.5rem', borderRadius: '8px', width: '300px' }}>
                Equipe
            </h2>
            <p><strong>Projeto:</strong> {equipe.nome_do_projeto || 'Sem projeto associado'}</p>
            <button onClick={handleVerGitHub} style={{ color: '#393' }}>Ver GitHub</button>

            <h4 style={{ marginTop: '1rem', marginBottom: '0.5rem' }}>Membros:</h4>
            <ul style={{ textAlign: 'left', paddingLeft: '1.2rem' }}>
                {equipe.membros.map((membro, index) => (
                    <li key={index}>
                        {membro.nome} - <small style={{ color: '#666' }}>{membro.papel}</small>
                    </li>
                ))}
            </ul>
            <button
                onClick={onVerSprints} 
                style={{
                    marginTop: '1rem',
                    width: '100%',
                    padding: '0.5rem',
                    backgroundColor: '#0070f3',
                    color: 'white',
                    border: 'none',
                    borderRadius: '4px',
                    cursor: 'pointer',
                    fontWeight: 'bold'
                }}
            >
                Ver Sprints
            </button>
        </div>
    );
}