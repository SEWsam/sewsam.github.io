<script>
    import { reveal } from "svelte-reveal";
    import { afterUpdate } from "svelte";
    import GithubLogo from "./assets/github.svg"
    import EmailIcon from "./assets/email.svg"

    let show = false;
    afterUpdate(() => {
        show = true;
    });
</script>

{#if show}
<div id="about">
    <div id="about-container" use:reveal={{transition: "fly"}}>
        <div id="about-text">
            <p id="name">
            SEWsam
            </p>
            <p>Hobbyist developer.</p>
        </div>
        <div id="socials">
            <a href="https://github.com/SEWsam">
                <img src={GithubLogo} alt="github" />
            </a>
            <a href="mailto:sam@sewsam.dev">
                <img src={EmailIcon} alt="email"/>
            </a>
        </div>
    </div>
</div>
{/if}

<style>
    #about {
        width: 95vw;
        height: 100vh;
        margin-top: auto;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    #about-container {
        width: 100%;
        height: 85%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    #about-text {
        width: 50%;
        display: flex;
        flex-direction: column;
    }


    #name {
        font-size: 11vmin;
        font-weight: 900;
        margin-bottom: 0;
        margin-top: 0;
    }

    #socials {
        display: flex;
        width: 25%;
        
    }

    #socials a {
        padding: 0px 7px 0px 7px;
    }
    #socials img {
        width: 100%;
    }
</style>